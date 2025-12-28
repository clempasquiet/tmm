######################################################################
#                                                                    #
# This file provides internal configuration that is required for     #
# proper operation of the TMM. It is for INTERNAL USE ONLY.          #
#                                                                    #
######################################################################

if { [string compare $platform "Z100"] == 0 } {
    #
    # Run non-realtime scheduling policy without yielding when we have enough
    # extra VCPUs to pin network IRQs to. We assume that 8 VCPUs are sufficient.
    # The rationale is that we expect two high traffic interfaces (one external
    # and one internal), four rx/tx IRQs per interface (for the i40evf driver
    # for which we're optimizing), and we want to pin one IRQ to each VCPU.
    #
    set extra_vcpus [expr $ncpu - $npus]
    set min_extra_vcpus 8

    if { $extra_vcpus >= $min_extra_vcpus } {
        realtime no
        realtime yield 0
    }
} else {
    #
    # Run non-realtime scheduling policy without yielding in split planes mode.
    # A realtime policy with yielding is unnecessary because the control plane
    # and TMMs are isolated from one another.
    #
    if { $ncpu > $npus } {
      realtime yield 0
    }
}

#
# Don't rebalance on 1 CPU.
#
if { $npus == 1 } {
  realtime rebalance no
}

if { [string compare $platform "C36"] == 0 } {
  scheduler::rtc_frequency 2048
  scheduler::sleep_range 122070 1000000
} elseif { [string compare $platform "Z100"] == 0 } {
  scheduler::rtc_frequency 4096
  scheduler::sleep_range 250000 250000
  clock_advance_threshhold 300
} elseif { [string compare $platform "Z101"] == 0 } {
  scheduler::rtc_frequency 4096
  scheduler::sleep_range 250000 250000
  # Single hyperthread guest
  if { $ncpu == 1 } {
      realtime yield 20
  }
} elseif { [string compare $platform "A108"] == 0 } {
  realtime rebalance_ceiling 97
  realtime rebalance_backoff_min_sleep no
}

#
# TMM has priority over normal priority tasks
#
nice -19

#
# Set the default configuration for clientside and serverside
# SSL proxies, respectively.  
# In order to change clientciphers/serverciphers, we also need to change
# (1) SSL_DEFAULT_CLIENTCIPHERS/SSL_DEFAULT_SERVERCIPHERS in
#     f5lib/includes/f5ssl.h
# (2) clientciphers/serverssl ciphers in
#     tmm/test/unittest/tmm_base.tcl
#
set ssl_ciphers_default         "ECDHE-RSA-AES128-GCM-SHA256:"
append ssl_ciphers_default      "ECDHE-RSA-AES128-CBC-SHA:"
append ssl_ciphers_default      "ECDHE-RSA-AES128-SHA256:"
append ssl_ciphers_default      "ECDHE-RSA-AES256-GCM-SHA384:"
append ssl_ciphers_default      "ECDHE-RSA-AES256-CBC-SHA:"
append ssl_ciphers_default      "ECDHE-RSA-AES256-SHA384:"
append ssl_ciphers_default      "AES128-GCM-SHA256:"
append ssl_ciphers_default      "AES128-SHA:"
append ssl_ciphers_default      "AES128-SHA256:"
append ssl_ciphers_default      "AES256-GCM-SHA384:"
append ssl_ciphers_default      "AES256-SHA:AES256-SHA256:"
append ssl_ciphers_default      "CAMELLIA128-SHA:"
append ssl_ciphers_default      "CAMELLIA256-SHA:"
append ssl_ciphers_default      "ECDHE-ECDSA-AES128-GCM-SHA256:"
append ssl_ciphers_default      "ECDHE-ECDSA-AES128-SHA:"
append ssl_ciphers_default      "ECDHE-ECDSA-AES128-SHA256:"
append ssl_ciphers_default      "ECDHE-ECDSA-AES256-GCM-SHA384:"
append ssl_ciphers_default      "ECDHE-ECDSA-AES256-SHA:"
append ssl_ciphers_default      "ECDHE-ECDSA-AES256-SHA384:"
append ssl_ciphers_default      "DHE-RSA-AES128-GCM-SHA256:"
append ssl_ciphers_default      "DHE-RSA-AES128-SHA:"
append ssl_ciphers_default      "DHE-RSA-AES128-SHA256:"
append ssl_ciphers_default      "DHE-RSA-AES256-GCM-SHA384:"
append ssl_ciphers_default      "DHE-RSA-AES256-SHA:"
append ssl_ciphers_default      "DHE-RSA-AES256-SHA256:"
append ssl_ciphers_default      "DHE-RSA-CAMELLIA128-SHA:"
append ssl_ciphers_default      "DHE-RSA-CAMELLIA256-SHA:"
append ssl_ciphers_default      "ECDHE-RSA-DES-CBC3-SHA:"
append ssl_ciphers_default      "DHE-RSA-CAMELLIA256-SHA:"
append ssl_ciphers_default      "DES-CBC3-SHA:"
append ssl_ciphers_default      "ECDHE-ECDSA-DES-CBC3-SHA:"
append ssl_ciphers_default      "DHE-RSA-DES-CBC3-SHA:"
append ssl_ciphers_default      "!SSLv2:-SSLv3"

clientciphers $ssl_ciphers_default
serverciphers $ssl_ciphers_default

set IP_ADDR_LOCALHOST [ip_addr localhost]
#
# Read /etc/services and /etc/protocols into the service
# and ipproto arrays. Note that these arrays are valid only
# for configuration. They are not valid for rules.
#
namespace eval tmm {
    set fname "/etc/services"
    if { [catch {set fid [open $fname r]} ] } {
        puts stderr "Could not open file $fname for reading."
        exit 1
    }
    while {[gets ${fid} line] != -1} {
        if {[regexp {^#.*} $line]} { continue }
        if {[regexp {(\S+)\s+(\d+)/(udp|tcp)} $line match name port]} {
            set ::service($name) $port
        }
    }
    close ${fid}

    set fname "/etc/protocols"
    if { [catch {set fid [open $fname r]} ] } {
        puts stderr "Could not open file $fname for reading."
        exit 1
    }
    while {[gets ${fid} line] != -1} {
        if {[regexp {^#.*} $line]} { continue }
        if {[regexp {(\S+)\s+(\d+)} $line match name proto]} {
            set ::ipproto($name) $proto
            # build reverse mapping for proto -> name
            set ::ipname($proto) $name
        }
    }
    # overwrite ipname(0) with "*"
    set ::ipname(0) "*"
    #  fill unknown protocols with numbers
    for {set i 1} {$i <= 255} {incr i} {
        if { not [info exists ::ipname($i)] } {
            set ::ipname($i) $i
        }
    }
    close ${fid}
}

#
# filter constraints
#
constrain ACCESS require HTTP
constrain ADAPT require HTTP
constrain ADM require HTTP
constrain ANTIFRAUD require HTTP
constrain AVR require HTTP
constrain DOSL7 require HTTP
constrain CSS require REWRITE
constrain DEFLATE require HTTP
constrain DEMANGLE require HTTP
constrain DIAMETER preclude {HTTP FTP TFTP SIPP RTSP}
constrain FTP require TCP
constrain TFTP require UDP
constrain HTML require REWRITE
constrain HTTP preclude {FTP TFTP UDP SCTP}
constrain ICAP_CS require IVS_ENTRY
constrain INFLATE require HTTP
constrain IPOTHER preclude {TCP UDP}
constrain ISESSION preclude serverside CONNPOOL
constrain LINE require TCP
constrain MSRDP require TCP preclude {HTTP FTP TFTP }
constrain NULL require TCP
constrain OAUTH require HTTP
constrain PPTP require TCP
constrain QOE require HTTP
constrain RAMCACHE require HTTP
constrain REWRITE require HTTP
constrain RTSP require TCP
constrain SCTP preclude {TCP IPOTHER UDP}
constrain SMTPS require SSL
# constrain LDAP require SSL
constrain SPDY require HTTP
constrain SOCKS require TCP
constrain SOCKS preclude {FTP TFTP HTTP SIPP}
constrain WEBSOCKET require HTTP
constrain SPLITSESSION require TCP
constrain SSID require TCP
constrain STREAM require TCP
constrain TCP preclude {UDP IPOTHER SCTP}
constrain UDP preclude {TCP IPOTHER SCTP}

# services - serverside half proxies
#

# syslog UDP client (port 514)
#     :<syslog client> <- UDP:
proxy SYSLOG {
    use server $IP_ADDR_LOCALHOST $service(syslog)
    serverside UDP
}

# sflow UDP client
#     :<sflow client> <- UDP:
profile udp _sflowudp {
    idle_timeout -1
}

proxy SFLOW {
    clientside UDP
    serverside UDP
    profile _sflowudp
}

profile tcp swgtcp {
    reset_on_timeout     1
    time_wait_recycle    1
    delayed_acks         0
    selective_acks       0
    deferred_accept      0
    ecn                  0
    limited_transmit     1
    auto_nagle           1
    timestamps           0
    slow_start           0
    ack_on_push          1
    idle_timeout         300
    time_wait_timeout    2000
    fin_wait_timeout     5
    close_wait_timeout   5
    sndbuf               131072
    keep_alive_interval  60
    syn_maxrtx           3
    maxrtx               8
}

# AntServer Connection TCP client
proxy SWG_TCP {
    serverside TCP
    profile swgtcp
}

# High Speed Logging TCP client
# :<hslogging client> <- TCP:
proxy MDS_TCP {
    serverside TCP
}

# High Speed Logging UDP client
# :<hslogging client> <- UDP:
proxy MDS_UDP {
    serverside UDP
}

# IPFIX SCTP client
# :<ipfix client> <- SCTP:
proxy MDS_SCTP {
    serverside SCTP
}

# IPFIX TLS client
# :<ipfix client> <- TLS:
proxy MDS_TLS {
    serverside TCP SSL
}


# High Speed Logging Userland Proxy (f5lib/errdefs/errdefs_local.h)
#   :UDP -> <HSL>:
proxy MDS_PROXY {
    listen [ip_addr shared] 3792 {
        proto $ipproto(udp)
        tap enable tmm0
        no_arp
    }
    clientside UDP
}

# IPFIX Logging Userland Proxy (port 0xedf0 - 60912)
#   :TCP -> <IPFIX>:
proxy IPFIX_LOGGING_PROXY {
    listen [ip_addr shared] 0xedf0 {
        proto $ipproto(tcp)
        tap enable tmm0
        no_arp
    }
    clientside TCP
}

#PCP Client
proxy PCP {
    hudchain PCP   
    clientside UDP
}

# mcp TCP client
#
profile tcp _mcptcp {
    reset_on_timeout enable
    time_wait_recycle enable
    delayed_acks enable
    selective_acks enable
    slow_start disable
    auto_nagle disable
    ack_on_push enable
    keep_alive_interval 20
    sndbuf 4194304
    rcvwnd 4194304
    congestion_ctrl 3
    syn_maxrtx 3
    maxrtx 4
    fin_wait_timeout 5
    close_wait_timeout 5
}

# mcpd TCP client
#     :<mcpd client> <- TCP:
proxy MCP {
    use server $IP_ADDR_LOCALHOST $service(mcpd)
    serverside TCP
    profile _mcptcp
}

# tmrouted client for dynamic routes
proxy TMROUTED {
    use server $IP_ADDR_LOCALHOST $service(router)
    serverside TCP4
    profile _mcptcp
}

# gtmd TCP client
#
profile tcp _gtmtcp {
    time_wait_recycle enable
    delayed_acks enable
    selective_acks enable
    slow_start disable
    auto_nagle disable
    ack_on_push enable
    sndbuf 4194304
    rcvwnd 4194304
    congestion_ctrl 3
    syn_maxrtx 3
    maxrtx 4
    fin_wait_timeout 5
    close_wait_timeout 5
}

# gtm TCP client
#     :<gtm client> <- TCP:
proxy GTM {
    use server $IP_ADDR_LOCALHOST $service(gtmd)
    serverside TCP
    profile _gtmtcp
}

# resolver UDP client (port 53)
#     :<resolver client> <- UDP:
proxy RESOLV {
    use server $IP_ADDR_LOCALHOST $service(domain)
    serverside UDP
}

# DNS cache resolver UDP client
#     :<cache client> <- UDP:
proxy DNS_RESOLV_UDP {
    serverside UDP
}

# DNS cache resolver TCP client
#     :<cache client> <- TCP:
proxy DNS_RESOLV_TCP {
    serverside TCP
}

ltp_profile_class antserver_class {
}

ltp_profile antserver_class antserver {
    plugin_channel "mem://antserver"
    plugin_name "AntServer plugin"
    plugin_type "PLUGIN"
    plugin_cmp enable
    plugin_connection_backlog 10000
    plugin_threads "tmms"
}

ltp_profile_class urldb_class {
}

ltp_profile urldb_class urldb {
    plugin_channel "mem://urldb"
    plugin_name "URL DB plugin"
    plugin_type "PLUGIN"
    plugin_cmp enable
    plugin_connection_backlog 10000
    plugin_threads "tmms"
}

ltp_profile_class lucenedb_class {
}

ltp_profile lucenedb_class lucenedb {
    plugin_channel "mem://lucenedb"
    plugin_name "Lucene DB plugin"
    plugin_type "PLUGIN"
    plugin_cmp enable
    plugin_connection_backlog 100
    plugin_threads "tmms1-1"
}

proxy LUCENEDB {
        serverside TCP4 PLUGIN
            profile lucenedb
}

#used for tmm to APMD communication
#XXX modify this to bring proxy up only when
# apm is provisoned

ltp_profile_class apmd_class {
}

ltp_profile apmd_class apmd {
    plugin_channel "mem://apmd"
    plugin_name "apmd"
    plugin_type "PLUGIN"
    plugin_cmp enable
    plugin_connection_backlog 10000
    plugin_threads "tmms1-1"
}

#used for tmm to SSO communication
ltp_profile_class apm_sso_class {
}

ltp_profile apm_sso_class apm_sso {
    plugin_channel "mem://apm_sso"
    plugin_name "apm_sso"
    plugin_type "PLUGIN"
    plugin_cmp enable
    plugin_connection_backlog 10000
    plugin_threads "tmms1-1"
}

ltp_profile_class oauthdb_class {
}

ltp_profile oauthdb_class oauthdb {
    plugin_channel "mem://oauth"
    plugin_name "oauthplugin"
    plugin_type "PLUGIN"
    plugin_cmp enable
    plugin_connection_backlog 10000
    plugin_threads "tmms1-1"
}

proxy OAUTHDB {
    serverside TCP4 PLUGIN
    profile oauthdb
}

#
# The following profiles are used for APM OAuth AS functionality
# to support admin initiated token revocation.
#
profile oauth _tmm_apm_oauth_oauth {
    db_instance "/Common/oauthdb"
    token_revocation_url "/f5-oauth2/v1/revoke"
}

profile http _tmm_apm_oauth_http {
}

profile tcp _tmm_apm_oauth_tcp {
}

# lacpd UDP client
#     UDP -> <lacpd client> <- UDP:
proxy LAC {
    listen [ip_addr bcast] $service(lacpd) {
        proto $ipproto(udp)
        tap enable tmm0
        l2forward
    }
    clientside UDP
    serverside UDP
}

# cert/key/ca are set later
ltp_profile serverssl _ha_cgc_serverssl {
    peer_cert_mode 1
    mode 1
    vfy_accept 1
}
profile clientssl _ha_cgc_clientssl {
    peer_cert_mode 1
    mode 1
}

# High Availability state mirroring server and client
#     :TCP4 -> SSL -> <ha server>:
#     :<ha client> -> SSL -> TCP4:
# HA TCP4 defaults
profile tcp _tcp4_ha_defaults {
    idle_timeout 30
    keep_alive_interval 1
    maxrtx 4
    syn_maxrtx 3
    rcvwnd 4194304
    sndbuf 4194304
    delayed_acks enabled
    time_wait_recycle enabled
    deferred_accept disabled
    selective_acks enabled
    dsack disabled
    ecn disabled
    limited_transmit enabled
    timestamps enabled
    slow_start disabled
    auto_nagle enabled
    ack_on_push disabled
    abc enabled
    cmetrics_cache enabled
    congestion_ctrl 3
    delay_window_control disabled
    mptcp disabled
    mss 0
}

proxy HA {
    hudchain HA_MIRROR
    clientside TCP4 SSL
    serverside TCP4 SSL
    profile clientside _ha_cgc_clientssl
    profile serverside _ha_cgc_serverssl
    profile _tcp4_ha_defaults
}

# tcpdump service (port 2).
#     UDP -> <TCPDUMP service> <- UDP:
proxy TCPDUMP {
    listen [ip_addr bcast] $service(tcpdump) {
        proto $ipproto(udp)
        tap enable tmm0
        l2forward
        no_arp
    }
    clientside UDP
    serverside UDP
}

proxy TCPDUMP {
    listen [ip_addr this_tmm] $service(tcpdump) {
        proto $ipproto(udp)
        tap enable tmm0
        l2forward
    }
    clientside UDP
    serverside UDP
}

# Random service (port 3).
#   :UDP -> <random service>:
proxy RND {
    listen [ip_addr this_tmm] 3 {
        proto $ipproto(udp)
        tap enable tmm0
    }
    clientside UDP
}

# Neuron service (port 10009).
#   :TCP -> <neuron service>:
proxy NEURON {
    listen [ip_addr this_tmm] 10009 {
        proto $ipproto(tcp)
        tap enable tmm0
    }
    clientside TCP
}

proxy IPSECCFG {
    use server $IP_ADDR_LOCALHOST $service(ipsecd)
    serverside TCP
    profile _mcptcp
}

# Plugin capture service (port 4)
#   :UDP -> <plugin capture service>:
proxy PLUGIN_CAPTURE {
    listen [ip_addr this_tmm] 4 {
        proto $ipproto(udp)
        tap enable tmm0
    }
    clientside UDP
    serverside UDP
}

# Plugin capture service (port 4)
#   :UDP -> <plugin capture service>:
proxy PLUGIN_CAPTURE {
    listen [ip_addr bcast] 4 {
        proto $ipproto(udp)
        tap enable tmm0
        l2forward
        no_arp
    }
    clientside UDP
    serverside UDP
}

# ping IPv4/IPv6 client
#     :<ping client>:
proxy PING {
}

#
# Serdes TCP tunnel.
#    :TCP -> <Serdes Tunnel> <- TCP:
proxy SERDES {
    clientside TCP
    serverside TCP
}

profile  bigproto _bigproto {
    tcp_server_time_wait_timeout 0
}

profile bigproto _bigself {
    ip_ttl_mode 1
    reset_on_timeout enable
}

#
# full proxies
#

# Transparent IP proxy (protocol IPPROTO_ANY).
#     :IP -> <IP proxy> <- IP:
proxy BIGPROTO {
    hudchain BIGPROTO
    profile _bigproto
}

# Transparent IP proxy (protocol IPPROTO_ANY).
#     :IP -> <IP proxy> <- IP:
proxy BIGSELF {
    hudchain BIGSELF
    profile _bigself
}

# Transparent IP proxy (protocol IPPROTO_ANY).
#     :IP -> <IP proxy> <- IP:
proxy BIGRELATED {
    hudchain BIGRELATED
    profile _bigproto
}

proxy BIGLSN {
    hudchain BIGLSN
}

proxy PPTPGRE {
    hudchain PPTPGRE
}

# Used for clone pool support.
proxy CLONE {
    hudchain CLONE
}

proxy BIGFTP {
    hudchain FTP
    profile _bigproto
}

# Used for iclient ctrl connection. 
proxy ICLIENT {
    hudchain ICLIENT
    clientside TCP
}

# Transparent IP proxy (protocol IPPROTO_ANY) for host OS tap.
proxy BIGSELF {
    listen 0.0.0.0%${rtdom_any} 0 netmask 0.0.0.0 {
        proto $ipproto(any)
        transparent
        no_translate
        no_arp
        l2forward
        tap enable all
    }
    listen 0.0.0.0%${rtdom_any} 0 netmask 0.0.0.0 {
        proto $ipproto(icmp)
        idle_timeout 10
        transparent
        no_translate
        no_arp
        l2forward
        tap enable all
    }
    listen 0.0.0.0%${rtdom_any} 0 netmask 0.0.0.0 {
        proto $ipproto(udp)
        idle_timeout 30
        transparent
        no_translate
        no_arp
        l2forward
        tap enable all
    }
    listen ::%${rtdom_any} 0 netmask :: {
        proto $ipproto(any)
        transparent
        no_translate
        no_arp
        l2forward
        tap enable all
    }
    listen ::%${rtdom_any} 0 netmask :: {
        proto $ipproto(ipv6-icmp)
        idle_timeout 10
        transparent
        no_translate
        no_arp
        l2forward
        tap enable all
    }
    listen ::%${rtdom_any} 0 netmask :: {
        proto $ipproto(udp)
        idle_timeout 30
        transparent
        no_translate
        no_arp
        l2forward
        tap enable all
    }
    profile _bigself
}

# Transparent FTP proxy for host OS tap.
proxy BIGFTP {
    listen 0.0.0.0%${rtdom_any} 21 netmask 0.0.0.0 {
        proto $ipproto(tcp)
        transparent
        no_translate
        no_arp
        tap enable all
    }
    listen ::%${rtdom_any} 21 netmask :: {
        proto $ipproto(tcp)
        transparent
        no_translate
        no_arp
        tap enable all
    }
}

profile udp _cdp_udp {
    # Allow fragmentation
    ip_df_mode 2
}

# F5 Cluster Discovery
proxy CDP {
    listen 224.0.0.1 62965 {
        proto $ipproto(udp)
        l2forward
        vlan cluster
    }
    clientside UDP
    serverside UDP
    profile _cdp_udp
}

# Drop multicast frames from clusterd on tmm_bp 
proxy DROP {
    listen 224.0.0.0 0 netmask 240.0.0.0 {
        proto $ipproto(any)
        l2forward
        vlan cluster
    }
}

# MPI proxies
#
# For the MPI network transport, there is a proxy for reliable (stream)
# and unreliable (datagram) messages.  There is only a serverside for the
# datagram proxy as the MPI nodes perform simultaneous connects
#
profile tcp mpitcp {
    reset_on_timeout enable
    time_wait_recycle enable
    delayed_acks enable
    selective_acks enable
    timestamps enable
    slow_start disable
    auto_nagle disable
    ack_on_push enable
    sndbuf 1048575
    rcvwnd 1048575
    congestion_ctrl 3
    keep_alive_interval 1
    syn_maxrtx 0
    maxrtx 4
    fin_wait_timeout 5
    close_wait_timeout 5
}

proxy MPISTREAM {
    clientside TCP
    serverside TCP
    profile mpitcp
}

profile udp mpiudp {
}

proxy MPIDGRAM {
    serverside UDP
    profile mpiudp
}

# Ramcache proxy
profile tcp rcptcp {
    time_wait_recycle enable
    delayed_acks enable
    selective_acks enable
    timestamps enable
    slow_start disable
    auto_nagle disable
    ack_on_push enable
    sndbuf 1048575
    rcvwnd 1048575
    congestion_ctrl 3
    syn_maxrtx 0
    maxrtx 4
    fin_wait_timeout 5
    close_wait_timeout 5
}
proxy RCP {
    clientside TCP
    serverside TCP
    profile rcptcp
}

# IP deny proxy (protocol IPPROTO_ANY) for port lock down.
#     :IP -> <DENY> :
proxy DENY {
    hudchain DENY
}

# IP drop proxy (protocol IPPROTO_ANY) for port lock down.
#     :IP -> <DROP> :
proxy DROP {
    hudchain DROP
}

# TODO: Remove BFDCTRL proxy. Select dynamically.
# BFDCTRL proxy (RFC 5880)
#   It handles BFD Control & Echo packets from BFD neighbor
#   Listeners are created on-demand
#   : UDP -> <BFDCTRL> :  (BFD Control/Echo packet is UDP payload)
#   ttl value is set to 255 for ipv4 and ipv6 as per RFC 5881
#   section 5.
profile udp _bfdctrludp {
    ip_ttl_mode 3
    ip_ttl_v4 255
    ip_ttl_v6 255
}

proxy BFDCTRL {
    clientside UDP
    serverside UDP
    profile _bfdctrludp
}

# BFDMGMT proxy (RFC 5880)
#   It handles ZebOS<-->TMM communication for BFD session management
#   Listener is defined below, bfd-echo port reused
#   : UDP -> <BFDMGMT> :  (BFD mgmt packet is UDP payload)
proxy BFDMGMT {
    listen [ip_addr this_tmm]%${rtdom_any} $service(bfd-echo) {
        proto $ipproto(udp)
        tap enable tmm0
        no_arp
    }
    clientside UDP
}

# IKE proxy
#     :IP -> <IKE proxy> <- IP:
proxy IKE {
}

proxy WOC {
    use server $IP_ADDR_LOCALHOST $service(wocd)
    serverside TCP
}

profile tcp _woctunnel_tcp {
    idle_timeout 1000
    keep_alive_interval 6
    rcvwnd 65535
    sndbuf 65535
    congestion_ctrl 3
    selective_acks enabled
    selective_nack enabled
    dsack enabled
    auto_nagle disabled
    syn_maxrtx 3
    maxrtx 8
    fin_wait_timeout 5
    close_wait_timeout 5
    zero_window_timeout 300000
    verified_accept true
    pkt_loss_ignore_rate 10000
    pkt_loss_ignore_burst 8
}

profile isession _woctunnel_isession {
    mode true
    connection_reuse false
    compression false
    compression_adaptive false
    deduplication false
    port_transparency false
    encrypt true
}

profile isession _mntrtunnel_isession {
    mode true
    connection_reuse false
    compression false
    compression_adaptive false
    deduplication false
    port_transparency false
    encrypt true
}

profile tcp _mntrtunnel_tcp {
    idle_timeout 1000
    keep_alive_interval 6
    rcvwnd 65535
    sndbuf 65535
    congestion_ctrl 3
    selective_acks enabled
    selective_nack enabled
    dsack enabled
    auto_nagle disabled
    syn_maxrtx 3
    maxrtx 8
    fin_wait_timeout 5
    close_wait_timeout 5
    zero_window_timeout 300000
    verified_accept true
    pkt_loss_ignore_rate 10000
    pkt_loss_ignore_burst 8
}

proxy TCP {
    hudchain WOCTUNNEL
    clientside TCP
    serverside TCP SSL ISESSION
    profile _woctunnel_isession
    profile _woctunnel_tcp
}

proxy TCP {
    hudchain MNTRTUNNEL
    clientside TCP
    serverside TCP SSL ISESSION
    profile _mntrtunnel_isession
    profile _mntrtunnel_tcp
}

proxy TCP {
    hudchain APMAAAHATCP
    clientside TCP
    serverside TCP
}

ltp_profile serverssl _apm_aaa_serverssl {
    mode 1
}

proxy IP {
    hudchain APMAAAHAUDP
    clientside UDP
    serverside UDP
}

ltp_profile serverssl _mam_serverssl {
    mode 1
}

proxy TCP {
    hudchain MAMSSL
    clientside TCP
    serverside TCP SSL
    profile _mam_serverssl
}

# Initialize FP components.
# This is a temporary place for this initialization.
# It may change later and may get hard-coded inside TMM.
profile tcp _tmm_firepass_memcached_internal_tcp {
    reset_on_timeout     1
    time_wait_recycle    1
    delayed_acks         0
    selective_acks       1
    deferred_accept      0
    ecn                  0
    limited_transmit     1
    auto_nagle           1
    timestamps           1
    slow_start           1
    ack_on_push          0
    idle_timeout         300
    time_wait_timeout    2000
    fin_wait_timeout     5
    close_wait_timeout   5
    sndbuf               64000
    rcvwnd               64000
    keep_alive_interval  1800
    syn_maxrtx           3
    maxrtx               8
}

proxy MEMCACHED {
    clientside TCP
    profile _tmm_firepass_memcached_internal_tcp
    listen [ip_addr this_tmm] 11211 {
        proto $ipproto(tcp)
        tap enable tmm0
    }
    listen [ip_addr shared] 11211 {
        proto $ipproto(tcp)
        tap enable tmm0
        no_arp
    }
}

pool _tmm_firepass_apd_pool {
    member $IP_ADDR_LOCALHOST 10001
}

pool _tmm_firepass_apd_pool_chassis {
    member 127.20.1.254 10001
    member 127.20.2.254 10001
    member 127.20.3.254 10001
    member 127.20.4.254 10001
    member 127.20.5.254 10001
    member 127.20.6.254 10001
    member 127.20.7.254 10001
    member 127.20.8.254 10001
    member 127.20.9.254 10001
    member 127.20.10.254 10001
    member 127.20.11.254 10001
    member 127.20.12.254 10001
}

#
# Following config objects are used by APM internal virtual.
#
profile tcp _tmm_apm_portal_tcp {
}
profile http _tmm_apm_portal_http {
}
pool _tmm_firepass_renderer_pool {
    member $IP_ADDR_LOCALHOST 8888
}

rule _tmm_apm_acl_rule {
    when CLIENT_ACCEPTED {
        ACL::eval
        NETWORKACCESS::snat -session
        if {[IP::protocol] == 17} {
            IP::idle_timeout 30
        }
    }
}

profile http _tmm_apm_http {
}
profile access _tmm_apm_acl {
}
rule _tmm_apm_netaccess_rule {
    when CLIENT_ACCEPTED {
        if { [ACL::eval -l7] == 0 } {
            HTTP::disable
        }
        NETWORKACCESS::snat -session
    }
}
#
#

profile httpcompression _tmm_inflate {
}

profile rewrite _tmm_rewrite {
    rewrite_mode 1
}

profile html _tmm_html {
    content_selection "text/html text/xhtml"
}

profile tcp _tmm_antserver_tcp {
    reset_on_timeout     1
    time_wait_recycle    1
    delayed_acks         0
    selective_acks       1
    deferred_accept      0
    ecn                  0
    limited_transmit     1
    auto_nagle           1
    timestamps           1
    slow_start           0
    ack_on_push          0
    idle_timeout         300
    time_wait_timeout    2000
    fin_wait_timeout     5
    close_wait_timeout   5
    sndbuf               131072
    rcvwnd               65535
    keep_alive_interval  60
    syn_maxrtx           3
    maxrtx               8
}

pool _tmm_antserver_pool {
    member $IP_ADDR_LOCALHOST 54321 limit 1
    queue enable
}

proxy TCP {
    listen [ip_addr this_tmm] 54321 {
        proto $ipproto(tcp)
    }
    profile _tmm_antserver_tcp
    clientside TCP
    serverside TCP
    use pool _tmm_antserver_pool
}

#
# CMI Communication Configuration.
#
cgc::public_port 4353

# cgc TCP client
#
profile tcp _cgctcp_out {
    auto_nagle disable
    ack_on_push enable
    fin_wait_timeout 5
    close_wait_timeout 5
    idle_timeout 10
    keep_alive_interval 5
    sndbuf 131072
    rcvwnd 65535
    verified_accept true
    syn_maxrtx 3
    maxrtx 4
    timestamps 1
}
profile tcp _cgctcp_in {
    auto_nagle disable
    ack_on_push enable
    fin_wait_timeout 5
    close_wait_timeout 5
    idle_timeout 10
    keep_alive_interval 5
    sndbuf 131072
    rcvwnd 65535
    syn_maxrtx 3
    maxrtx 4
    timestamps 1 
}

# Default profile, used when no SNI is supplied.
ltp_profile serverssl _cgc_default_serverssl {
    mode 1
    vfy_accept 1
}
profile clientssl _cgc_default_clientssl { mode 1 }
cgc::map _cgc_default_clientssl _cgc_default_serverssl default 4353 false

# Profile for CGC communication
profile clientssl _cgc_cgc_clientssl {
     peer_cert_mode 1
     mode 1
}
ltp_profile serverssl _cgc1_cgc_serverssl {
     server_name cgc1.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
}
cgc::map _cgc_cgc_clientssl _cgc1_cgc_serverssl cgc1.cgc.f5.com 6698

profile serverssl _cgc_test_serverssl {
     server_name test.cgc.f5.com
     peer_cert_mode 1
     mode 1
}
cgc::map _cgc_cgc_clientssl _cgc_test_serverssl test.cgc.f5.com 10001

ltp_profile serverssl _cgc2_cgc_serverssl {
     server_name cgc2.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
     drop_untrust_ca 1
     drop_exp_cert 1
}
cgc::map _cgc_cgc_clientssl _cgc2_cgc_serverssl cgc2.cgc.f5.com 6699

ltp_profile serverssl _cgc3_cgc_serverssl {
     server_name cgc3.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
}
cgc::map _cgc_cgc_clientssl _cgc3_cgc_serverssl cgc3.cgc.f5.com 1028

# Profile for ASM communication
profile clientssl _cgc_asm_clientssl {
     peer_cert_mode 1
     mode 1
}
ltp_profile serverssl _cgc_asm1_serverssl {
     server_name asm1.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
}
ltp_profile serverssl _cgc_asm2_serverssl {
     server_name asm2.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
}
ltp_profile serverssl _cgc_asm3_serverssl {
     server_name asm3.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
}
ltp_profile serverssl _cgc_asm4_serverssl {
     server_name asm4.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
}
ltp_profile serverssl _cgc_asm5_serverssl {
     server_name asm5.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
}
ltp_profile serverssl _cgc_asm6_serverssl {
     server_name asm6.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
}
cgc::map _cgc_asm_clientssl _cgc_asm1_serverssl asm1.cgc.f5.com 6123
cgc::map _cgc_asm_clientssl _cgc_asm2_serverssl asm2.cgc.f5.com 6124
cgc::map _cgc_asm_clientssl _cgc_asm3_serverssl asm3.cgc.f5.com 6125
cgc::map _cgc_asm_clientssl _cgc_asm4_serverssl asm4.cgc.f5.com 6126
cgc::map _cgc_asm_clientssl _cgc_asm5_serverssl asm5.cgc.f5.com 6127
cgc::map _cgc_asm_clientssl _cgc_asm6_serverssl asm6.cgc.f5.com 6128

# Profiles for AVR reporter
profile clientssl _cgc_avr_reporter_clientssl {
     peer_cert_mode 1
     mode 1
}
ltp_profile serverssl _cgc_avr_reporter_serverssl {
     server_name avr.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
}
cgc::map _cgc_avr_reporter_clientssl _cgc_avr_reporter_serverssl avr.cgc.f5.com 9090

# Profiles for WAM Symmetric/Farm
profile clientssl _cgc_wam_farm_clientssl {
     peer_cert_mode 1
     mode 1
}
ltp_profile serverssl _cgc_wam_farm_serverssl {
     server_name wam.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
}
cgc::map _cgc_wam_farm_clientssl _cgc_wam_farm_serverssl wam.cgc.f5.com 6050

# Profiles for ASM config remote access
profile clientssl _cgc_asm_config_clientssl {
     peer_cert_mode 1
     mode 1
}
ltp_profile serverssl _cgc_asm_config_serverssl {
     server_name asmconfig.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
}
cgc::map _cgc_asm_config_clientssl _cgc_asm_config_serverssl asmconfig.cgc.f5.com 9781

# Profile for rsync
ltp_profile serverssl _cgc_rsync_serverssl {
     server_name rsync.cgc.f5.com
     peer_cert_mode 1
     mode 1
     vfy_accept 1
}
cgc::map _cgc_cgc_clientssl _cgc_rsync_serverssl rsync.cgc.f5.com 873 false

# Outgoing rules for serverssl
rule _cgc_match_cn {
    when CLIENT_ACCEPTED {
        set IP_ADDR_TMM_IF [ip_addr tmm_if]
        if { ([IP::addr [IP::client_addr] equals $IP_ADDR_TMM_IF]) || ([IP::addr [IP::client_addr] equals fe80::0/32]) } {
            snat automap
        } else {
            snat [IP::client_addr]
        }
    }

    when SERVER_CONNECTED {
        # Determine the destination ssl profile
        set cport [peer { TCP::local_port }]
        set port_map [CGC::port $cport]
        set sni [lindex $port_map 2]

        if { $sni == "default" } {
            # Disable outbound SSL for existing iQuery traffic.
            SSL::disable
        } else {
            set ssl_profile [lindex $port_map 1]
            set ssl_profile_enable "SSL::profile $ssl_profile"

            # Set the profile to the correct one, based on the desired port.
            catch { eval $ssl_profile_enable }

            unset ssl_profile
            unset ssl_profile_enable
        }

        # Cleanup
        unset cport
        unset port_map
        unset sni
    }
}

proxy TCP {
    hudchain CGC_OUT
    clientside TCP
    serverside TCP SSL
    profile _cgc_default_serverssl
    profile _cgctcp_out
    rule _cgc_match_cn
}

# Incoming CGC details to differentiate between different targets.
rule _cgc_pick_clientside {
    when CLIENT_ACCEPTED {
        set cgc_detect_hs 1
        SSL::disable
        TCP::collect
    }

    when CLIENTSSL_CLIENTCERT {
        set ssl_errcode [SSL::verify_result]
        set ssl_errstr [X509::verify_cert_error_string $ssl_errcode]
        set peerip [IP::remote_addr]

        if { ($ssl_errcode != 0) } {
            log -noname local0. "CMI peer $peerip certificate rejected, error $ssl_errcode: $ssl_errstr"
        }

        unset ssl_errcode
        unset ssl_errstr
        unset peerip
    }

    when CLIENT_DATA {
        if { ($cgc_detect_hs) } {
            binary scan [TCP::payload] cSS tls_xacttype tls_version tls_recordlen
            switch $tls_version {
                "769" -
                "770" -
                "771" {
                    if { ($tls_xacttype == 22) } {
                        binary scan [TCP::payload] @5c tls_action
                        if { not (($tls_action == 1) && ([TCP::payload length] > $tls_recordlen)) } {
                            set cgc_detect_hs 0
                        }
                    }
                }
                default {
                    set cgc_detect_hs 0
                }
            }
            if { ($cgc_detect_hs) } {
                set record_offset 43
                binary scan [TCP::payload] @${record_offset}c tls_sessidlen
                set record_offset [expr {$record_offset + 1 + $tls_sessidlen}]
                binary scan [TCP::payload] @${record_offset}S tls_ciphlen
                set record_offset [expr {$record_offset + 2 + $tls_ciphlen}]
                binary scan [TCP::payload] @${record_offset}c tls_complen
                set record_offset [expr {$record_offset + 1 + $tls_complen}]

                if { ([TCP::payload length] >= $record_offset) } {
                    binary scan [TCP::payload] @${record_offset}S tls_extenlen
                    set record_offset [expr {$record_offset + 2}]
                    binary scan [TCP::payload] @${record_offset}a* tls_extensions

                    if { ([info exists tls_extenlen]) } {
                        for { set x 0 } { $x < $tls_extenlen } { incr x 4 } {
                            set start [expr {$x}]
                            binary scan $tls_extensions @${start}SS etype elen
                            if { ($etype == "00") } {
                                set grabstart [expr {$start + 9}]
                                set grabend [expr {$elen - 5}]
                                binary scan $tls_extensions @${grabstart}A${grabend} tls_servername
                                set start [expr {$start + $elen}]
                            } else {
                                set start [expr {$start + $elen}]
                            }
                            set x $start
                        }
                    }
                    if { ([info exists tls_servername] ) } {
                        set list_map [CGC::sni $tls_servername]
                        set ssl_profile [lindex $list_map 0]
                        set cgc_target_port [lindex $list_map 3]
                        set cgc_target_host [IP::local_addr]

                        if { $ssl_profile == "" } {
                            log local0. "CGC: $tls_servername : no match, drop connection"
                            reject
                        } else {
                            set IP_ADDR_SHARED [ip_addr shared]
                            if { ([IP::addr $cgc_target_host equals $IP_ADDR_SHARED]) ||
                                    ($cgc_target_port == 9090) || ($cgc_target_port == 9781) } {
                                set cgc_target_host [ip_addr localhost]
                                snat automap
                            } else {
                                snat [IP::remote_addr]
                            }
                            set ssl_profile_enable "SSL::profile $ssl_profile"
                            catch { eval $ssl_profile_enable }
                            set cgc_target_set "node $cgc_target_host $cgc_target_port"
                            catch { eval $cgc_target_set }
                            SSL::enable
                        }
                    } else {
                        set list_map [CGC::sni "default"]
                        set ssl_profile [lindex $list_map 0]
                        set cgc_target_port [lindex $list_map 3]
                        set cgc_target_host [IP::local_addr]

                        if { $ssl_profile == "" } {
                            log local0. "CGC: $tls_servername : no match, drop connection"
                            reject
                        } else {
                            set cgc_target_set "node $cgc_target_host $cgc_target_port"
                            catch { eval $cgc_target_set }
                            snat [IP::remote_addr]
                        }
                        SSL::disable
                        TCP::release
                    }
                } else {
                    SSL::enable
                }
                set cgc_detect_hs 0
                TCP::release
            } else {
                set cgc_detect_hs 0
                TCP::release
            }
        }
    }
}

# cgc_incoming 
proxy TCP {
    hudchain CGC_IN
    clientside TCP SSL
    serverside TCP
    profile clientside _cgc_default_clientssl
    profile _cgctcp_in
    rule _cgc_pick_clientside
}

## Default driver specification for native drivers. Can be overrridden from
## from tmm_init.tcl
device driver vendor_dev 8086:154c ixlv
# All other NIC
device driver class 2 unic

#
# Customizations should be added to tmm_init.tcl
#
if {[file exists "tmm_init.tcl"]} {
    source "tmm_init.tcl"
} elseif {[file exists "/config/tmm_init.tcl"]} {
    source "/config/tmm_init.tcl"
}

#
# Platform-specific initialization
#
if {[file exists "tmm_platform.tcl"]} {
    source "tmm_platform.tcl"
} elseif {[file exists "/usr/lib/tmm/tmm_platform.tcl"]} {
    source "/usr/lib/tmm/tmm_platform.tcl"
}

# 
# Drop packets coming from outside the box whose destination net address 
# is loopback address - 127/8 (IPv4) or ::1 (IPv6)
#
proxy DENY {
    listen 127.0.0.0%${rtdom_any} 0 netmask 255.0.0.0 {
        proto $ipproto(any)
        no_arp
        vlan enable all
    }
    listen ::1%${rtdom_any} 0 {
        proto $ipproto(any)
        no_arp
        vlan enable all
    }
}

# Drop packets coming from inside the box (tap) whose destination net
# address is loopback address - 127/8 (IPv4) or ::1 (IPv6)
#
proxy DENY {
    listen 127.0.0.0 0 netmask 255.0.0.0 {
        proto $ipproto(any)
        no_arp
        tap enable all
    }
    listen ::1 0 {
        proto $ipproto(any)
        no_arp
        tap enable all
    }
}

profile udp _tmm_sip_monitor_udp {
    idle_timeout 10
}

# Force SIPP to disable persistence lookups with an invalid header name.
profile persist _tmm_sip_monitor_persist {
    mode 6
    sip_info NOTVALID
}

profile sipp _tmm_sip_monitor_sip {
    insert_via enabled
}

rule _tmm_sip_monitor {
    when SIP_REQUEST {
        # The 'node' command doesn't support [ipv6]:port notation
        eval node [string map { {[} "" {]:} " " } [SIP::header X-_tmm_monitor]]
        SIP::header remove X-_tmm_monitor
    }
}

# Internal proxy for handling UDP SIP monitor requests from the host.  Adds
# a Via header so that the response is routed back to the BIG-IP appropriately.
proxy MLB {
    listen [ip_addr shared] 5060 {
        proto $ipproto(udp)
        tap enable tmm0
        no_arp
    }
    clientside UDP SIPP
    serverside UDP SIPP
    profile _tmm_sip_monitor_persist _tmm_sip_monitor_sip _tmm_sip_monitor_udp
    rule _tmm_sip_monitor
}

# stpd UDP client
#     UDP -> <stpd client> <- UDP:
proxy STP {
    listen [ip_addr bcast] $service(stpd) {
        proto $ipproto(udp)
        tap enable tmm0
        l2forward
    }
    clientside UDP
    serverside UDP
}

# lldpd UDP client
#     UDP -> <lldpd client> <- UDP:
proxy LLDP {
    listen [ip_addr bcast] $service(lldpd) {
        proto $ipproto(udp)
        tap enable tmm0
        l2forward
    }
    clientside UDP
    serverside UDP
}

# Pass ingress IGMP and PIM traffic to the host.
proxy BIGSELF {
    listen 224.0.0.0%${rtdom_any} 0 netmask 240.0.0.0 {
        proto $ipproto(igmp)
        idle_timeout 0
        transparent
        no_translate
        no_arp
        l2forward
        vlan enable all
    }
    listen 224.0.0.0%${rtdom_any} 0 netmask 240.0.0.0 {
        proto $ipproto(pim)
        idle_timeout 0
        transparent
        no_translate
        no_arp
        l2forward
        vlan enable all
    }
    listen ff00::%${rtdom_any} 0 netmask ff:: {
        proto $ipproto(pim)
        idle_timeout 0
        transparent
        no_translate
        no_arp
        l2forward
        vlan enable all
    }
    profile _bigself
}

# Ensures TMM does not change RIP port from 520 to some unused port for egress traffic
proxy BIGSELF {
    listen 0.0.0.0%${rtdom_any} $service(router) netmask 0.0.0.0 {
        proto $ipproto(udp)
        srcport strict
        transparent
        no_translate
        no_arp
        l2forward
        tap enable all
    }
    profile _bigself
}

# PIM half-proxy
#   Handles ZebOS<-->TMM communication for PIM routing messages
proxy PIM {
    listen [ip_addr this_tmm]%${rtdom_any} $service(pim-port) {
        proto $ipproto(tcp)
        tap enable tmm0
        no_arp
    }
    profile _mcptcp
    clientside TCP
}

# Profiles for Key management operations.
profile tcp _km_tcp {
    close_wait_timeout 5
    fin_wait_timeout 5
    maxrtx 8
    syn_maxrtx 3
    reset_on_timeout true
    time_wait_recycle true
    selective_acks true
    ack_on_push true
    congestion_ctrl 3
}

profile http _km_http {
}

profile serverssl _km_serverssl {
    mode 1
}

# Profiles for ECM
profile tcp _ecm_tcp {
    reset_on_timeout true
    time_wait_recycle true
    delayed_acks true
    idle_timeout 300
    time_wait_timeout 20000
    fin_wait_timeout 2
    close_wait_timeout 2
    sndbuf 32768
    rcvwnd 32768
    proxy_buffer_high 131072
    proxy_buffer_low 8192
    keep_alive_interval 750000
    syn_maxrtx 4
    maxrtx 4
    slow_start disable

}

profile http _ecm_http {
}

profile httpcompression _ecm_http_compression {
    allow_http_10 disabled
    browser_workarounds disabled
    buffer_size 4096
    content_type_excludes none
    content_type_includes { text/ "application/(xml|x-javascript)" }
    cpusaver enabled
    cpusaver_high 90
    cpusaver_low 75
    gzip_level 1
    gzip_memlevel 8000
    gzip_windowsize 16000
    keep_accept_encoding disabled
    preferred_method 1
    min_size 20
    selective disabled
    uri_excludes none
    uri_includes { .* }
    vary_header enabled
}

profile serverssl _ecm_ssl {
    authenticate_once 1
    authenticate_depth 9
}

# TCP profile for Ping Accesss
profile tcp _pingaccess_tcp {
}

# HTTP profile for Ping Access
profile http _pingaccess_http {
}

# Persistence profile for Ping Access Pool, Mode is Cookie and Method is Cookie-Insert
ltp_profile persist __pingaccess_persist {
    mode 3
    cookie_method 1
}

# Profile for APM IVS filter. Currently used to apply iRules on traffic going
# to Ping Access Server.
ltp_profile apm_ivs __apm_ivs {
}

# New profile class for Ping Access Plugin
ltp_profile_class ping_agent_class {
}

# Plugin profile for Ping Access Plugin
ltp_profile ping_agent_class ping_agent {
    plugin_channel "mem://ping"
    plugin_name "PING ACCESS AGENT PLUGIN"
    plugin_type "PLUGIN"
    plugin_cmp enable
    plugin_connection_backlog 10000
    plugin_threads "tmms1-1"
}
