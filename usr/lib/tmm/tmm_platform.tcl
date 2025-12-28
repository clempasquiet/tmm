#
# Control/status registers for HSB (High Speed Bridge)'s LBB (Local Bus Bridge)
#
HSB::dump_reg lbb 0x00000 4 lbb_scratch_1
HSB::dump_reg lbb 0x00004 4 lbb_scratch_2
HSB::dump_reg lbb 0x00008 4 lbb_scratch_3
HSB::dump_reg lbb 0x0000c 4 lbb_scratch_4
HSB::dump_reg lbb 0x00010 4 lbb_scratch_5
HSB::dump_reg lbb 0x00014 4 lbb_scratch_6
HSB::dump_reg lbb 0x00018 4 lbb_flow_control_0
HSB::dump_reg lbb 0x0001c 4 lbb_flow_control_1
HSB::dump_reg lbb 0x00020 4 lbb_flow_control_sticky_0
HSB::dump_reg lbb 0x00024 4 lbb_flow_control_sticky_1
HSB::dump_reg lbb 0x00028 4 lbb_pcie_tlp_error
HSB::dump_reg lbb 0x0002c 4 lbb_strapping_inputs
HSB::dump_reg lbb 0x00030 4 cleaner_framing_error_count
HSB::dump_reg lbb 0x00034 4 cleaner_CRC_error_count
HSB::dump_reg lbb 0x00030 4 pde_watchdog_timout_limit
HSB::dump_reg lbb 0x00034 4 pcie_linkdown_count
HSB::dump_reg lbb 0x00038 4 debug_out_test
HSB::dump_reg lbb 0x0003c 4 led_test
HSB::dump_reg lbb 0x00040 4 lbb_rd_except_stat
HSB::dump_reg lbb 0x00044 4 lbb_wr_except_stat
HSB::dump_reg lbb 0x00048 4 pcie_phy_control_reg
HSB::dump_reg lbb 0x000A0 4 pcie_core0_error_sticky
HSB::dump_reg lbb 0x000A4 4 pcie_core1_error_sticky

HSB::dump_reg lbb 0x00100 4 lbb_status
HSB::dump_reg lbb 0x00100 4 lbb_debug1
HSB::dump_reg lbb 0x00104 4 lbb_debug2
HSB::dump_reg lbb 0x00104 4 hgm_soft_reset

HSB::dump_reg lbb 0x00200 4 pte_tx_l2t_src_port_id_src_mod_id
HSB::dump_reg lbb 0x00204 4 pde_watchdog_timeout_limit
HSB::dump_reg lbb 0x00208 4 higig_mirror_override

HSB::dump_reg lbb 0x00300 4 hsb_fpga_device
HSB::dump_reg lbb 0x00304 4 hsb_type
HSB::dump_reg lbb 0x00308 4 hsb_build_version
HSB::dump_reg lbb 0x0030c 4 hsb_date_version
HSB::dump_reg lbb 0x00310 4 hsb_debug_modes

HSB::dump_reg lbb 0x00400 4 hsb_top_capability_header
HSB::dump_reg lbb 0x00404 4 hsb_top_capability_scratch
HSB::dump_reg lbb 0x00408 4 hsb_top_capability_0
HSB::dump_reg lbb 0x0040c 4 hsb_top_capability_1
HSB::dump_reg lbb 0x00410 4 hsb_top_capability_2
HSB::dump_reg lbb 0x00414 4 hsb_top_capability_3
HSB::dump_reg lbb 0x00418 4 hsb_top_capability_4
HSB::dump_reg lbb 0x0041c 4 hsb_top_capability_5

# TODO: these capability blocks are the default offset register addresses
# Thus, although they offer very useful debug info, it is necessary to verify
# the accuracy of them by following the linked list
# from the TOP capability block in "hsb_top_capability_header"
HSB::dump_reg lbb 0x00420 4 hsb_dma_capability_header_default
HSB::dump_reg lbb 0x00424 4 hsb_dma_capability_scratch_default
HSB::dump_reg lbb 0x00428 4 hsb_dma_capability_0_default
HSB::dump_reg lbb 0x0042c 4 hsb_dma_capability_1_default

HSB::dump_reg lbb 0x00430 4 hsb_flow_cache_capability_header_default
HSB::dump_reg lbb 0x00434 4 hsb_flow_cache_capability_scratch_default
HSB::dump_reg lbb 0x00438 4 hsb_flow_cache_capability_0_default
HSB::dump_reg lbb 0x0043c 4 hsb_flow_cache_capability_1_default
HSB::dump_reg lbb 0x00440 4 hsb_flow_cache_capability_2_default

HSB::dump_reg lbb 0x00444 4 hsb_ddos_capability_header_default
HSB::dump_reg lbb 0x00448 4 hsb_ddos_capability_scratch_default
HSB::dump_reg lbb 0x0044c 4 hsb_ddos_capability_0_default
HSB::dump_reg lbb 0x00450 4 hsb_ddos_capability_1_default
HSB::dump_reg lbb 0x00454 4 hsb_ddos_capability_2_default
HSB::dump_reg lbb 0x00458 4 hsb_ddos_capability_3_default
HSB::dump_reg lbb 0x0045c 4 hsb_ddos_capability_4_default

HSB::dump_reg lbb 0x00460 4 hsb_efad_capability_header_default
HSB::dump_reg lbb 0x00464 4 hsb_efad_capability_scratch_default
HSB::dump_reg lbb 0x00468 4 hsb_efad_capability_0_default
HSB::dump_reg lbb 0x0046c 4 hsb_efad_capability_1_default
HSB::dump_reg lbb 0x00470 4 hsb_efad_capability_2_default
HSB::dump_reg lbb 0x00474 4 hsb_efad_capability_3_default
HSB::dump_reg lbb 0x00478 4 hsb_efad_capability_4_default
HSB::dump_reg lbb 0x0047c 4 hsb_efad_capability_5_default
HSB::dump_reg lbb 0x00480 4 hsb_efad_capability_6_default

for { set j 0 } {$j < 4} {incr j 1} {
    HSB::dump_reg lbb [expr 0x00800 + 0x20 * $j] 4 pte_pde_${j}_pkt_fifo_full_drops
}

HSB::dump_reg lbb 0x00880 4 pte_parser_state_machine_err_flags
HSB::dump_reg lbb 0x00884 4 pte_dbg_1
HSB::dump_reg lbb 0x00888 4 pte_dbg_2
HSB::dump_reg lbb 0x0088c 4 pte_dbg_3
HSB::dump_reg lbb 0x00890 4 pte_dbg_4

HSB::dump_reg lbb 0x00a00 4 hes_error_status
HSB::dump_reg lbb 0x00a04 4 hes_him_error_status

HSB::dump_reg lbb 0x00c00 4 qbi_hg_dport_to_pde_map0
HSB::dump_reg lbb 0x00c04 4 qbi_hg_dport_to_pde_map1

for { set j 0 } {$j < 4} {incr j 1} {
    for { set p 0 } {$p < 4} {incr p 1} {
        HSB::dump_reg lbb [expr 0x00c10 + 0x8 * $p + 0x20 * $j] 4 qbi_fifo_pde_${j}_pri_${p}_min_addr
        HSB::dump_reg lbb [expr 0x00c14 + 0x8 * $p + 0x20 * $j] 4 qbi_fifo_pde_${j}_pri_${p}_max_addr
    }
}

HSB::dump_reg lbb 0x00c94 4 qbi_truncates
HSB::dump_reg lbb 0x00c98 4 qbi_overrun
HSB::dump_reg lbb 0x00c9c 4 qbi_error_flags

HSB::dump_reg lbb 0x00ca0 4 qbi_mem_access_pending
HSB::dump_reg lbb 0x00ca4 4 qbi_mem_access_ctrl
HSB::dump_reg lbb 0x00ca8 4 qbi_mem_access_addr

for { set j 0 } {$j < 5} {incr j 1} {
    HSB::dump_reg lbb [expr 0x00cac + 0x4 * $j] 4 qbi_mem_access_data_${j}
}

HSB::dump_reg lbb 0x00cc4 4 sram_parity_error_sticky_bit

HSB::dump_reg lbb 0x00cc8 4 qbi_debug1
HSB::dump_reg lbb 0x00ccc 4 qbi_debug2
HSB::dump_reg lbb 0x00cd0 4 qbi_debug3
HSB::dump_reg lbb 0x00cd4 4 qbi_debug4
HSB::dump_reg lbb 0x00cd8 4 qbi_debug5
HSB::dump_reg lbb 0x00cdc 4 qbi_debug6
HSB::dump_reg lbb 0x00ce0 4 qbi_debug7
HSB::dump_reg lbb 0x00ce4 4 qbi_debug8
HSB::dump_reg lbb 0x00ce8 4 qbi_debug9
HSB::dump_reg lbb 0x00cec 4 qbi_debug10
HSB::dump_reg lbb 0x00cf0 4 qbi_debug11
HSB::dump_reg lbb 0x00cf4 4 qbi_debug12
HSB::dump_reg lbb 0x00cf8 4 qbi_debug13
HSB::dump_reg lbb 0x00cfc 4 qbi_debug14
HSB::dump_reg lbb 0x00f90 4 qbi_debug15
HSB::dump_reg lbb 0x00f94 4 qbi_debug16

for { set j 0 } {$j < 16} {incr j 1} {
    HSB::dump_reg lbb [expr 0x00d00 + 0x4 * $j] 4 qbi_dropped_packets_ring_${j}
}

for { set j 0 } {$j < 16} {incr j 1} {
    HSB::dump_reg lbb [expr 0x00d40 + 0x4 * $j] 4 qbi_forwarded_packets_ring_${j}
}

for { set j 0 } {$j < 16} {incr j 1} {
    HSB::dump_reg lbb [expr 0x00d80 + 0x4 * $j] 4 qbi_dropped_bytes_ring_${j}
}

for { set j 0 } {$j < 16} {incr j 1} {
    HSB::dump_reg lbb [expr 0x00dc0 + 0x4 * $j] 4 qbi_forwarded_bytes_ring_${j}
}

HSB::dump_reg lbb 0x00f94 4 sram_parity_error_count
HSB::dump_reg lbb 0x00f98 4 sram_parity_error_count2

HSB::dump_reg lbb 0x01000 4 pim_diag_counter_0_0
HSB::dump_reg lbb 0x01004 4 pim_diag_counter_0_1
HSB::dump_reg lbb 0x01024 4 pim_diag_state_dst_port_0
HSB::dump_reg lbb 0x01028 4 pim_diag_state_dst_port_1
HSB::dump_reg lbb 0x01030 4 pim_diag_prefetch_fifo_flags_src_0
HSB::dump_reg lbb 0x01034 4 pim_diag_prefetch_fifo_flags_src_1
HSB::dump_reg lbb 0x01038 4 pim_diag_prefetch_fifo_flags_src_2
HSB::dump_reg lbb 0x0103c 4 pim_diag_port_0_errors
HSB::dump_reg lbb 0x01040 4 pim_diag_port_1_errors
HSB::dump_reg lbb 0x01044 4 pim_diag_port_1_errors


HSB::dump_reg lbb 0x01000 4 xal_scratch_register
HSB::dump_reg lbb 0x01004 4 xal_free_tag_count
HSB::dump_reg lbb 0x01008 4 xal_free_memory_0
HSB::dump_reg lbb 0x0100c 4 xal_free_memory_1
HSB::dump_reg lbb 0x01010 4 xal_max_tag_used
HSB::dump_reg lbb 0x01014 4 xal_hds1_outstanding_tags_0
HSB::dump_reg lbb 0x01018 4 xal_hds1_outstanding_tags_1
HSB::dump_reg lbb 0x0101c 4 xal_hds1_outstanding_tags_2
HSB::dump_reg lbb 0x01020 4 xal_hds1_outstanding_tags_3
HSB::dump_reg lbb 0x01024 4 xal_hds1_outstanding_tags_4
HSB::dump_reg lbb 0x01028 4 xal_hds1_outstanding_tags_5
HSB::dump_reg lbb 0x0102C 4 xal_hds1_outstanding_tags_6

HSB::dump_reg lbb 0x01030 4 xal_hds1_outstanding_tags_7
HSB::dump_reg lbb 0x01034 4 xal_lbb_fifo_drops
HSB::dump_reg lbb 0x01038 4 xal_hde1_tag_limits
HSB::dump_reg lbb 0x0103c 4 xal_hde2_tag_limits
HSB::dump_reg lbb 0x01040 4 xal_hde1_mem_p_limit
HSB::dump_reg lbb 0x01044 4 xal_hde1_mem_np_limit
HSB::dump_reg lbb 0x01048 4 xal_hde2_mem_p_limit
HSB::dump_reg lbb 0x0104C 4 xal_hde2_mem_np_limit
HSB::dump_reg lbb 0x01050 4 xal0_sticky_status_error

for { set j 0 } {$j < 20} {incr j 1} {
    HSB::dump_reg lbb [expr 0x01100 + 0x4 * $j] 4 xal_fixed_debug_${j}
}

HSB::dump_reg lbb 0x01400 4 xge_flow_control_thresholds
HSB::dump_reg lbb 0x01404 4 xge_rcv_overflow_count
HSB::dump_reg lbb 0x01408 4 xge_rcv_start_diag_counter
HSB::dump_reg lbb 0x0140c 4 xge_rx_fifo_full_drop_count
HSB::dump_reg lbb 0x01410 4 xge_packer_rx_fifo_start_count
HSB::dump_reg lbb 0x01414 4 xge_packer_rx_fifo_good_count
HSB::dump_reg lbb 0x01418 4 xge_packer_rx_fifo_bad_count

for { set j 0 } {$j < 20} {incr j 1} {
    HSB::dump_reg lbb [expr 0x01200 + 0x4 * $j] 4 xal_optional_debug_${j}
}



for { set j 0 } {$j < 4} {incr j 1} {
    HSB::dump_reg lbb [expr 0x01420 + 0x4 * $j] 4 xge_rcv_hg_dport_pim_map_${j}
}

HSB::dump_reg lbb 0x01430 4 xge_rx_pim_fifo_start_count
HSB::dump_reg lbb 0x01434 4 xge_rx_pim_fifo_good_count
HSB::dump_reg lbb 0x01434 4 xal1_lbb_fifo_drop
HSB::dump_reg lbb 0x01438 4 xge_rx_pim_fifo_bad_count

HSB::dump_reg lbb 0x01450 4 hg_mac_rx_cfg
HSB::dump_reg lbb 0x01454 4 hg_mac_tx_cfg
HSB::dump_reg lbb 0x01458 4 hg_mac_cfg

HSB::dump_reg lbb 0x01464 4 hg_mac_tx_host_frame
HSB::dump_reg lbb 0x01468 4 hg_mac_max_frame
HSB::dump_reg lbb 0x0146c 4 hg_mac_min_frame
HSB::dump_reg lbb 0x01470 4 hg_mac_pause_timer

HSB::dump_reg lbb 0x01490 4 hg_mac_tx_byte_cnt
HSB::dump_reg lbb 0x01494 4 hg_mac_tx_frame_cnt
HSB::dump_reg lbb 0x01498 4 hg_mac_tx_under_cnt
HSB::dump_reg lbb 0x0149c 4 hg_mac_tx_pxon_cnt
HSB::dump_reg lbb 0x014a0 4 hg_mac_tx_pxoff_cnt
HSB::dump_reg lbb 0x014a4 4 hg_mac_tx_status

HSB::dump_reg lbb 0x014a8 4 hg_mac_rx_byte_cnt
HSB::dump_reg lbb 0x014ac 4 hg_mac_rx_frame_cnt
HSB::dump_reg lbb 0x014b0 4 hg_mac_rx_ctrl_cnt
HSB::dump_reg lbb 0x014b4 4 hg_mac_rx_pxon_cnt
HSB::dump_reg lbb 0x014b8 4 hg_mac_rx_pxoff_cnt
HSB::dump_reg lbb 0x014bc 4 hg_mac_rx_crc_cnt
HSB::dump_reg lbb 0x014c0 4 hg_mac_rx_runt_cnt
HSB::dump_reg lbb 0x014c4 4 hg_mac_rx_err_cnt
HSB::dump_reg lbb 0x014c8 4 hg_mac_rx_ovrsize_cnt
HSB::dump_reg lbb 0x014cc 4 hg_mac_rx_end_cnt
HSB::dump_reg lbb 0x014d0 4 hg_mac_rx_good_cnt
HSB::dump_reg lbb 0x014d4 4 hg_mac_rx_bad_cnt
HSB::dump_reg lbb 0x014d8 4 hg_mac_rx_st_err_cnt
HSB::dump_reg lbb 0x014dc 4 hg_mac_rx_raw_err_cnt

HSB::dump_reg lbb 0x02000 4 tpg_destl2cfg
HSB::dump_reg lbb 0x02004 4 tpg_srcl2cfg
HSB::dump_reg lbb 0x0200c 4 rt_ackp_timeout
HSB::dump_reg lbb 0x02010 4 tpg_dropcnt

HSB::dump_reg lbb 0x02030 4 dma_readlimits
HSB::dump_reg lbb 0x02034 4 cache_coherency
HSB::dump_reg lbb 0x02038 4 dma_priority0
HSB::dump_reg lbb 0x0203c 4 dma_priority1

HSB::dump_reg lbb 0x02070 4 tpg_destlans0
HSB::dump_reg lbb 0x02074 4 tpg_destlans1

HSB::dump_reg lbb 0x02090 4 tpg_bad_snp_0
HSB::dump_reg lbb 0x02094 4 tpg_bad_snp_1
HSB::dump_reg lbb 0x02098 4 tpg_bad_snp_2
HSB::dump_reg lbb 0x0209C 4 tpg_bad_snp_3

for { set i 0 } {$i < 32} {incr i 1} {
    for { set j 0 } {$j < 4} {incr j 1} {
        HSB::dump_reg lbb [expr 0x02100 + 0x10 * $i + 0x4 * $j] 4 tpg_txpkt_pde${i}_r${j}
    }
}

# Dolomite TPG upper rings debug
if { ([string compare $platform "C115"] == 0) ||
     ([string compare $platform "C117"] == 0) ||
     ([string compare $platform "C120"] == 0) } {
    for { set i 0 } {$i < 16} {incr i 1} {
	HSB::dump_reg lbb [expr 0x02100 + 0x10 * $i + 0x200] 4 tpg_txpkt_pde${i}_r4
	HSB::dump_reg lbb [expr 0x02100 + 0x10 * $i + 0x204] 4 tpg_txpkt_pde${i}_r5
    }
}

HSB::dump_reg lbb 0x0e200 4 rqm_clean_cntl
HSB::dump_reg lbb 0x0e204 4 rqm_clean_cnt
HSB::dump_reg lbb 0x0e208 4 rqm_status
HSB::dump_reg lbb 0x0e20c 4 rqm_jumbo_drp_flags
HSB::dump_reg lbb 0x0e210 4 rqm_return_pkt_multides_limit

HSB::dump_reg lbb 0x0e230 4 ingress_drop_other
HSB::dump_reg lbb 0x0e234 4 ingress_clstr_iso_drp
HSB::dump_reg lbb 0x0e238 4 ingress_ukn_mod_drp
HSB::dump_reg lbb 0x0e23C 4 ingress_epva_bad_sa_drp
HSB::dump_reg lbb 0x0e240 4 bad_pde_dest

HSB::dump_reg lbb 0x06504 4 snp_fifo_cntl

#
# RQM registers, not available on Atlantis
#
if { ([string compare $platform "C115"] != 0) &&
     ([string compare $platform "C117"] != 0) &&
     ([string compare $platform "C120"] != 0) } {

    for { set j 0 } {$j < 32} {incr j 1} {
	HSB::dump_reg lbb [expr 0x0e320 + 0x4 * $j] 4 rqm_cnfg_debug_${j}
    }

    for { set j 0 } {$j < 3} {incr j 1} {
	HSB::dump_reg lbb [expr 0x0e400 + 0x20 * $j] 4 rqm_xge_crnt_status_que_${j}
	HSB::dump_reg lbb [expr 0x0e404 + 0x20 * $j] 4 rqm_xge_base_que_${j}
	HSB::dump_reg lbb [expr 0x0e408 + 0x20 * $j] 4 rqm_xge_limit_que_${j}
	HSB::dump_reg lbb [expr 0x0e40C + 0x20 * $j] 4 rqm_xge_crnt_wp_que_${j}
	HSB::dump_reg lbb [expr 0x0e410 + 0x20 * $j] 4 rqm_xge_crnt_rp_que_${j}
	HSB::dump_reg lbb [expr 0x0e414 + 0x20 * $j] 4 rqm_xge_fwd_cnt_que_${j}
	HSB::dump_reg lbb [expr 0x0e418 + 0x20 * $j] 4 rqm_xge_drp_cnt_que_${j}
	HSB::dump_reg lbb [expr 0x0e41C + 0x20 * $j] 4 rqm_xge_unused_que_${j}
    }

    for { set j 0 } {$j < 128} {incr j 1} {
	HSB::dump_reg lbb [expr 0x0e500 + 0x20 * $j] 4 rqm_dma_crnt_status_que_${j}
	HSB::dump_reg lbb [expr 0x0e504 + 0x20 * $j] 4 rqm_dma_base_que_${j}
	HSB::dump_reg lbb [expr 0x0e508 + 0x20 * $j] 4 rqm_dma_limit_que_${j}
	HSB::dump_reg lbb [expr 0x0e50C + 0x20 * $j] 4 rqm_dma_crnt_wp_que_${j}
	HSB::dump_reg lbb [expr 0x0e510 + 0x20 * $j] 4 rqm_dma_crnt_rp_que_${j}
	HSB::dump_reg lbb [expr 0x0e514 + 0x20 * $j] 4 rqm_dma_fwd_cnt_que_${j}
	HSB::dump_reg lbb [expr 0x0e518 + 0x20 * $j] 4 rqm_dma_drp_cnt_que_${j}
	HSB::dump_reg lbb [expr 0x0e51C + 0x20 * $j] 4 rqm_dma_unused_que_${j}
    }
}

HSB::dump_reg lbb 0x11000 4 netc_nrx_cfg
HSB::dump_reg lbb 0x11004 4 netc_nrx_pos
HSB::dump_reg lbb 0x11008 4 netc_nrx_ovfl_res
HSB::dump_reg lbb 0x1100c 4 netc_secret1
HSB::dump_reg lbb 0x11010 4 netc_secret2

#
# HSBE2V2: 4 NETC(s), HSBE2: 3 NETC(s)
#
for { set j 0 } {$j < 3} {incr j 1} {
    HSB::dump_reg lbb [expr 0x12000 + 256 * $j] 4 netc_bad_packet_drop_cnt_port_${j}
    HSB::dump_reg lbb [expr 0x12004 + 256 * $j] 4 netc_bad_ipc_drop_cnt_port_${j}
    HSB::dump_reg lbb [expr 0x12008 + 256 * $j] 4 netc_bad_l4c_drop_cnt_port_${j}
    HSB::dump_reg lbb [expr 0x1200C + 256 * $j] 4 netc_saf_ovrfl_drop_cnt_port_${j}
    HSB::dump_reg lbb [expr 0x12010 + 256 * $j] 4 netc_redag_mask_rx_cnt_${j}
    HSB::dump_reg lbb [expr 0x12018 + 256 * $j] 4 netc_runt_packet_drop_cnt_port_${j}
}

HSB::dump_reg lbb 0x13000 4 netc_aggregate_bad_packet_drop_cnt
HSB::dump_reg lbb 0x13004 4 netc_aggregate_ip_checksum_drop_cnt
HSB::dump_reg lbb 0x13008 4 netc_aggregate_layer_4_checksum_drop_cnt
HSB::dump_reg lbb 0x1300c 4 netc_aggregate_saf_overflow_drop_cnt
HSB::dump_reg lbb 0x13010 4 netc_aggregate_redag_mask_rx_cnt
HSB::dump_reg lbb 0x13018 4 netc_aggregate_runt_packet_drop_cnt

for { set j 0 } {$j < 32} {incr j 1} {
    HSB::dump_reg lbb [expr 0x13020 + 0x4 * $j] 4 netc_dag_sel_${j}
}

HSB::dump_reg lbb 0x130a0 4 netc_vcmp_p8_hash_cfg_reg0
HSB::dump_reg lbb 0x130a4 4 netc_vcmp_p8_hash_cfg_reg1

HSB::dump_reg lbb 0x1c000 4 netc_dos_scrub_period
HSB::dump_reg lbb 0x1c004 4 netc_dos_ipv6_extended_header_checks

# dump entire HSB/ePVA internal debug register section
for { set j 0 } {$j < 128} {incr j 1} {
    HSB::dump_reg lbb [expr 0x1f000 + 4 * $j] 4 hsbe2_dbg_${j}
}

# NETC 3 ePVA DEBUG register
HSB::dump_reg lbb 0x1f200 4 netc3_nrx_mp3_pktchk_dbg
HSB::dump_reg lbb 0x1f204 4 netc3_mp3_epva_pktchk_dbg
HSB::dump_reg lbb 0x1f208 4 netc3_epva_rqm_pktchk_dbg
HSB::dump_reg lbb 0x1f20c 4 netc3_mp3_dbg
HSB::dump_reg lbb 0x1f210 4 netc3_nrx_rd_dbg
HSB::dump_reg lbb 0x1f214 4 netc3_dag_a_dbg
HSB::dump_reg lbb 0x1f218 4 netc3_dag_b_dbg
HSB::dump_reg lbb 0x1f21c 4 netc3_pkt_5t_fif_dbg
HSB::dump_reg lbb 0x1f220 4 netc3_epva_pp_dbg
HSB::dump_reg lbb 0x1f224 4 netc3_epva_xf_dbg
HSB::dump_reg lbb 0x1f228 4 netc3_fc_dyn_dbg
HSB::dump_reg lbb 0x1f22c 4 netc3_fc_stky_dbg
HSB::dump_reg lbb 0x1f230 4 netc3_epva_pp_empty_dbg
HSB::dump_reg lbb 0x1f234 4 netc3_mal_dbg
HSB::dump_reg lbb 0x1f238 4 netc3_dos_dbg

HSB::dump_reg lbb 0x20000 4 netc_dir_modid
HSB::dump_reg lbb 0x20004 4 netc_vcmp_modid
HSB::dump_reg lbb 0x20008 4 netc_dag_lpbk
HSB::dump_reg lbb 0x2000c 4 netc_dag_upr_macsa
HSB::dump_reg lbb 0x20010 4 netc_dag_lwr_macsa
HSB::dump_reg lbb 0x20014 4 netc_dag_dst_ctl
HSB::dump_reg lbb 0x20018 4 netc_cos2ring

HSB::dump_reg lbb 0x20100 4 netc_vcmp_ip_only_cam_entry

for { set j 0 } {$j < 8} {incr j 1} {
    HSB::dump_reg lbb [expr 0x20104 + 4 *$j] 4 netc_vcmp_cam_entry_${j}
}

#
# ePVA/HGM registers, not available on Atlantis
#
if { ([string compare $platform "C115"] != 0) &&
     ([string compare $platform "C117"] != 0) &&
     ([string compare $platform "C120"] != 0) } {

    HSB::dump_reg lbb 0x2d000 4 netc_cache_valid_split_table_access
    HSB::dump_reg lbb 0x2d004 4 netc_noassist_split_table_access
    HSB::dump_reg lbb 0x2d008 4 netc_mac_sa_table_cfg_upper
    HSB::dump_reg lbb 0x2d00c 4 netc_mac_sa_table_cfg_lower
    HSB::dump_reg lbb 0x2d010 4 netc_mac_sa_table_ctl

    HSB::dump_reg lbb 0x2d01c 4 netc_epva_rcv_pcnt_0
    HSB::dump_reg lbb 0x2d020 4 netc_epva_rcv_pcnt_1
    HSB::dump_reg lbb 0x2d024 4 netc_epva_rcv_pcnt_2
    HSB::dump_reg lbb 0x2d028 4 netc_epva_nlu_pcnt_0
    HSB::dump_reg lbb 0x2d02c 4 netc_epva_nlu_pcnt_1
    HSB::dump_reg lbb 0x2d030 4 netc_epva_nlu_pcnt_2
    HSB::dump_reg lbb 0x2d034 4 netc_epva_hinv_pcnt_0
    HSB::dump_reg lbb 0x2d038 4 netc_epva_hinv_pcnt_1
    HSB::dump_reg lbb 0x2d03c 4 netc_epva_hinv_pcnt_2
    HSB::dump_reg lbb 0x2d040 4 netc_epva_nfm_pcnt_0
    HSB::dump_reg lbb 0x2d044 4 netc_epva_nfm_pcnt_1
    HSB::dump_reg lbb 0x2d048 4 netc_epva_nfm_pcnt_2
    HSB::dump_reg lbb 0x2d04c 4 netc_epva_vfm_pcnt_0
    HSB::dump_reg lbb 0x2d050 4 netc_epva_vfm_pcnt_1
    HSB::dump_reg lbb 0x2d054 4 netc_epva_vfm_pcnt_2

    HSB::dump_reg lbb 0x2d0bc 4 netc_epva_rcv_pcnt_3
    HSB::dump_reg lbb 0x2d0c0 4 netc_epva_nlu_pcnt_3
    HSB::dump_reg lbb 0x2d0c4 4 netc_epva_hinv_pcnt_3
    HSB::dump_reg lbb 0x2d0c8 4 netc_epva_nfm_pcnt_3
    HSB::dump_reg lbb 0x2d0cc 4 netc_epva_vfm_pcnt_3

    for { set j 0 } {$j < 32} {incr j 1} {
	HSB::dump_reg lbb [expr 0x2d100 + 4 * $j] 4 netc_epva_pcm_${j}
    }

    for { set j 0 } {$j < 32} {incr j 1} {
	HSB::dump_reg lbb [expr 0x2d200 + 4 * $j] 4 netc_epva_macsa_alloc_${j}
    }

    HSB::dump_reg lbb 0x2d500 4 netc_mss_table_0
    HSB::dump_reg lbb 0x2d504 4 netc_mss_table_1
    HSB::dump_reg lbb 0x2d508 4 netc_mss_table_2
    HSB::dump_reg lbb 0x2d50C 4 netc_mss_table_3

    for { set j 0 } {$j < 3} {incr j 1} {
	HSB::dump_reg lbb [expr 0x2d05c + 4 * $j] 4 netc_epva_update_max_duration_num_evts_port_${j}
	HSB::dump_reg lbb [expr 0x2d068 + 4 * $j] 4 netc_epva_update_total_evts_cnt_port_${j}
    }
}
HSB::dump_reg lbb 0x2e000 4 netc_epva_mgmt_cmd
HSB::dump_reg lbb 0x2e004 4 netc_epva_mgmt_static
HSB::dump_reg lbb 0x2e008 4 netc_epva_max_offset
HSB::dump_reg lbb 0x2e00C 4 netc_epva_crnt_entries
HSB::dump_reg lbb 0x2e010 4 netc_epva_max_entries
HSB::dump_reg lbb 0x2e014 4 netc_epva_crnt_inserts
HSB::dump_reg lbb 0x2e018 4 netc_epva_crnt_bumps
HSB::dump_reg lbb 0x2e01C 4 netc_epva_bad_snoops

for { set j 0 } {$j < 5} {incr j 1} {
    HSB::dump_reg lbb [expr 0x2e020 + 4 *$j]  4 netc_epva_bad_snoops_ext_${j}
}

HSB::dump_reg lbb 0x2e034 4 netc_epva_bad_unbumps
HSB::dump_reg lbb 0x2e038 4 netc_epva_crnt_dupes

for { set j 5 } {$j < 9} {incr j 1} {
    HSB::dump_reg lbb [expr 0x2e040 + 4 * ($j-5)]  4 netc_epva_bad_snoops_ext_${j}
}

for { set j 0 } {$j < 32} {incr j 1} {
    HSB::dump_reg lbb [expr 0x2e0f0 + 4 * $j] 4 netc_epva_inserts_${j}
    HSB::dump_reg lbb [expr 0x2e2f0 + 4 * $j] 4 netc_epva_evicts_${j}
    HSB::dump_reg lbb [expr 0x2e4f0 + 4 * $j] 4 netc_epva_snp_proc_${j}
    HSB::dump_reg lbb [expr 0x2e6f0 + 4 * $j] 4 netc_epva_snp_drp_${j}
    HSB::dump_reg lbb [expr 0x2e8f0 + 4 * $j] 4 netc_epva_fs_drp_${j}
}

HSB::dump_reg lbb 0x2eaf0 4 netc_epva_lk_max
HSB::dump_reg lbb 0x2eaf4 4 netc_epva_lk_full_0
HSB::dump_reg lbb 0x2eaf8 4 netc_epva_lk_full_1
HSB::dump_reg lbb 0x2eafc 4 netc_epva_lk_full_2
HSB::dump_reg lbb 0x2eb00 4 netc_epva_li_diag_clr

for { set j 0 } {$j < 3} {incr j 1} {
    HSB::dump_reg lbb [expr 0x2eb04 + 4 * $j] 4 netc_epva_lock_max_delay_num_delays_port_${j}
    HSB::dump_reg lbb [expr 0x2eb10 + 4 * $j] 4 netc_epva_lock_total_delays_port_${j}
}

if { ([string compare $platform "C115"] != 0) &&
     ([string compare $platform "C117"] != 0) &&
     ([string compare $platform "C120"] != 0) } {

    for { set j 0 } {$j < 3} {incr j 1} {

	HSB::dump_reg lbb [expr 0x4ee00 + 32 * $j] 4 rqm_vlan_fwd_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x4ee04 + 32 * $j] 4 rqm_vlan_fwd_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x4ee08 + 32 * $j] 4 rqm_vlan_fwd_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0x4ee10 + 32 * $j] 4 rqm_vlan_drp_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x4ee14 + 32 * $j] 4 rqm_vlan_drp_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x4ee18 + 32 * $j] 4 rqm_vlan_drp_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0x4f040 + 256 * $j] 4 rqm_hgm_fwd_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x4f044 + 256 * $j] 4 rqm_hgm_fwd_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x4f048 + 256 * $j] 4 rqm_hgm_fwd_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0x4f050 + 256 * $j] 4 rqm_hgm_drp_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x4f054 + 256 * $j] 4 rqm_hgm_drp_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x4f058 + 256 * $j] 4 rqm_hgm_drp_byte_cnt_lsb_${j}
    }

    for { set j 0 } {$j < 8} {incr j 1} {
	HSB::dump_reg lbb [expr 0x2eb20 + 4 * $j] 4 netc_epva_rows_${j}
	HSB::dump_reg lbb [expr 0x2eb40 + 4 * $j] 4 netc_epva_rows_${j}_max
    }
    HSB::dump_reg lbb 0x2eb60 4 netc_epva_row_ovf_cnt

    #
    # 4 HGM(s)
    #
    for { set j 0 } {$j < 4} {incr j 1} {
	HSB::dump_reg lbb [expr 0x31000 + 256 * $j] 4 hgm_rx_cfg_port_${j}
	HSB::dump_reg lbb [expr 0x31004 + 256 * $j] 4 hgm_tx_cfg_port_${j}
	HSB::dump_reg lbb [expr 0x31008 + 256 * $j] 4 hgm_mac_cfg_port_${j}
	HSB::dump_reg lbb [expr 0x3100C + 256 * $j] 4 hgm_xaui_cfg_port_${j}
	HSB::dump_reg lbb [expr 0x31010 + 256 * $j] 4 hgm_max_frame_size_port_${j}
	HSB::dump_reg lbb [expr 0x31014 + 256 * $j] 4 hgm_min_frame_size_port_${j}
	HSB::dump_reg lbb [expr 0x31018 + 256 * $j] 4 hgm_pause_timer_val_port_${j}
	HSB::dump_reg lbb [expr 0x3101C + 256 * $j] 4 hgm_mac_tx_pad_cfg_port_${j}
	HSB::dump_reg lbb [expr 0x31020 + 256 * $j] 4 hgm_xaui_status_port_${j}
	HSB::dump_reg lbb [expr 0x31024 + 256 * $j] 4 hgm_tx_frame_count_port_${j}
	HSB::dump_reg lbb [expr 0x31028 + 256 * $j] 4 hgm_rx_frame_count_port_${j}
	HSB::dump_reg lbb [expr 0x3102C + 256 * $j] 4 hgm_tx_pause_count_port_${j}
	HSB::dump_reg lbb [expr 0x31030 + 256 * $j] 4 hgm_rx_pause_count_port_${j}
	HSB::dump_reg lbb [expr 0x31034 + 256 * $j] 4 hgm_rx_bad_frame_count_port_${j}
    }

    #
    # 4 NETC and XLMAC. might not be always true for all platforms. offset 0x1000 
    #
    for { set j 0 } {$j < 4} {incr j 1} {
	HSB::dump_reg lbb [expr 0x4a000 + 4096 * $j] 4 xlmac_control_${j}
	HSB::dump_reg lbb [expr 0x4a004 + 4096 * $j] 4 xlmac_revision_${j}
	HSB::dump_reg lbb [expr 0x4a008 + 4096 * $j] 4 xlmac_status_${j}
	HSB::dump_reg lbb [expr 0x4a00c + 4096 * $j] 4 xlmac_counters_${j}
	HSB::dump_reg lbb [expr 0x4a010 + 4096 * $j] 4 xlmac_higig_tx_0_${j}
	HSB::dump_reg lbb [expr 0x4a014 + 4096 * $j] 4 xlmac_higig_tx_1_${j}
	HSB::dump_reg lbb [expr 0x4a018 + 4096 * $j] 4 xlmac_higig_tx_2_${j}
	HSB::dump_reg lbb [expr 0x4a01c + 4096 * $j] 4 xlmac_higig_tx_3_${j}
	HSB::dump_reg lbb [expr 0x4a020 + 4096 * $j] 4 xlmac_xoff_pause_crc_${j}
	HSB::dump_reg lbb [expr 0x4a024 + 4096 * $j] 4 xlmac_xon_pause_crc_${j}
	HSB::dump_reg lbb [expr 0x4a028 + 4096 * $j] 4 xlmac_txbytes_lo_cnt_${j}
	HSB::dump_reg lbb [expr 0x4a02c + 4096 * $j] 4 xlmac_txbytes_hi_cnt_${j}
	HSB::dump_reg lbb [expr 0x4a030 + 4096 * $j] 4 xlmac_txframes_${j}
	HSB::dump_reg lbb [expr 0x4a034 + 4096 * $j] 4 xlmac_rxbytes_lo_cnt_${j}
	HSB::dump_reg lbb [expr 0x4a038 + 4096 * $j] 4 xlmac_rxbytes_hi_cnt_${j}
	HSB::dump_reg lbb [expr 0x4a03c + 4096 * $j] 4 xlmac_rxbytes_rxframes_cnt_${j}
	HSB::dump_reg lbb [expr 0x4a040 + 4096 * $j] 4 xlmac_xgmiierr_cnt_${j}
	HSB::dump_reg lbb [expr 0x4a044 + 4096 * $j] 4 xlmac_fcserr_cnt_${j}
	HSB::dump_reg lbb [expr 0x4a048 + 4096 * $j] 4 xlmac_shorterr_cnt_${j}
	HSB::dump_reg lbb [expr 0x4a04c + 4096 * $j] 4 xlmac_longerr_cnt_${j}
	HSB::dump_reg lbb [expr 0x4a050 + 4096 * $j] 4 xlmac_rxpause_cnt_${j}
	HSB::dump_reg lbb [expr 0x4a054 + 4096 * $j] 4 xlmac_txpause_cnt_${j}
    }

    for {set j 0} {$j < 128} {incr j 1} {
	HSB::dump_reg lbb [expr 0x50020 + 256 * $j] 4 rqm_dma_fwd_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x50024 + 256 * $j] 4 rqm_dma_fwd_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x50028 + 256 * $j] 4 rqm_dma_fwd_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0x50030 + 256 * $j] 4 rqm_dma_drp_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x50034 + 256 * $j] 4 rqm_dma_drp_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x50038 + 256 * $j] 4 rqm_dma_drp_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0x50040 + 256 * $j] 4 rqm_epva_fwd_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x50044 + 256 * $j] 4 rqm_epva_fwd_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x50048 + 256 * $j] 4 rqm_epva_fwd_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0x50050 + 256 * $j] 4 rqm_epva_drp_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x50054 + 256 * $j] 4 rqm_epva_drp_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x50058 + 256 * $j] 4 rqm_epva_drp_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0x50060 + 256 * $j] 4 rqm_syn_fwd_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x50064 + 256 * $j] 4 rqm_syn_fwd_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x50068 + 256 * $j] 4 rqm_syn_fwd_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0x50070 + 256 * $j] 4 rqm_syn_drp_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x50074 + 256 * $j] 4 rqm_syn_drp_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x50078 + 256 * $j] 4 rqm_syn_drp_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0x50080 + 256 * $j] 4 rqm_fad_fwd_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x50084 + 256 * $j] 4 rqm_fad_fwd_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x50088 + 256 * $j] 4 rqm_fad_fwd_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0x50090 + 256 * $j] 4 rqm_fad_drp_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x50094 + 256 * $j] 4 rqm_fad_drp_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x50098 + 256 * $j] 4 rqm_fad_drp_byte_cnt_lsb_${j}
    }

    for {set j 0} {$j < 128} {incr j 1} {
	HSB::dump_reg lbb [expr 0x70000 + 32 * $j] 4 rqm_redag_fwd_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x70004 + 32 * $j] 4 rqm_redag_fwd_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x70008 + 32 * $j] 4 rqm_redag_fwd_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0x7000c + 32 * $j] 4 rqm_redag_fwd_clr_${j}
	HSB::dump_reg lbb [expr 0x70010 + 32 * $j] 4 rqm_redag_drp_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0x70014 + 32 * $j] 4 rqm_redag_drp_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0x70018 + 32 * $j] 4 rqm_redag_drp_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0x7001c + 32 * $j] 4 rqm_redag_drp_clr_${j}
    }
}

#
# Dolomite specific registers
#
if { ([string compare $platform "C115"] == 0) ||
     ([string compare $platform "C117"] == 0) ||
     ([string compare $platform "C120"] == 0) } {

    # ERTX Global registers
    HSB::dump_reg lbb 0xB0000 4 HIGIG_MODID
    HSB::dump_reg lbb 0xB0014 4 1G_RX_SAF_WMARK
    HSB::dump_reg lbb 0xB0018 4 10G_RX_SAF_WMARK
    HSB::dump_reg lbb 0xB001c 4 HGSHIM_DEBUG
    HSB::dump_reg lbb 0xB0034 4 TX_FCS_CONTROL

    # I2C debug
    HSB::dump_reg lbb 0xB0100 4 sfp_prescl_lo
    HSB::dump_reg lbb 0xB0104 4 sfp_prescl_hi
    HSB::dump_reg lbb 0xB0108 4 sfp_control
    HSB::dump_reg lbb 0xB010C 4 sfp_transmit
    HSB::dump_reg lbb 0xB0110 4 sfp_command
    HSB::dump_reg lbb 0xB0114 4 sfp_receive
    HSB::dump_reg lbb 0xB0118 4 sfp_status
    HSB::dump_reg lbb 0xB011C 4 sfp_reset
    HSB::dump_reg lbb 0xB0120 4 sfp_takeover
    HSB::dump_reg lbb 0xB0124 4 sfp_clk_cntrl
    HSB::dump_reg lbb 0xB0128 4 sfp_data_cntrl
    HSB::dump_reg lbb 0xB012C 4 sfp_data_status
    HSB::dump_reg lbb 0xB0130 4 sfp_clk_status

    # 1G port registers
    for { set j 0 } {$j < 4} {incr j 1} {
	HSB::dump_reg lbb [expr 0xB1000 + 0x400 * $j] 4 p${j}_ertx_reset
	HSB::dump_reg lbb [expr 0xB1004 + 0x400 * $j] 4 p${j}_phy_status
	HSB::dump_reg lbb [expr 0xB1008 + 0x400 * $j] 4 p${j}_port_vlan
	HSB::dump_reg lbb [expr 0xB100C + 0x400 * $j] 4 p${j}_sfp_cntrl
	HSB::dump_reg lbb [expr 0xB1010 + 0x400 * $j] 4 p${j}_link_updwn_cnt
	HSB::dump_reg lbb [expr 0xB1014 + 0x400 * $j] 4 p${j}_flow_cntrl

	for { set k 0x18 } {$k < 0x3d} {incr k 4} {
		HSB::dump_reg lbb [expr 0xB1000 + 0x400 * $j + $k] 4 p${j}_${k}_reserv
	}
	HSB::dump_reg lbb [expr 0xB1040 + 0x400 * $j] 4 p${j}_mac_rev
	HSB::dump_reg lbb [expr 0xB1044 + 0x400 * $j] 4 p${j}_scratch
	HSB::dump_reg lbb [expr 0xB1048 + 0x400 * $j] 4 p${j}_config
	HSB::dump_reg lbb [expr 0xB104c + 0x400 * $j] 4 p${j}_max_frm_len
	HSB::dump_reg lbb [expr 0xB1050 + 0x400 * $j] 4 p${j}_pause_quanta
	HSB::dump_reg lbb [expr 0xB1054 + 0x400 * $j] 4 p${j}_pause_gap
	HSB::dump_reg lbb [expr 0xB1058 + 0x400 * $j] 4 p${j}_pad
	HSB::dump_reg lbb [expr 0xB105c + 0x400 * $j] 4 p${j}_tx_ipg
	HSB::dump_reg lbb [expr 0xB1060 + 0x400 * $j] 4 p${j}_rx_section_empty
	HSB::dump_reg lbb [expr 0xB1064 + 0x400 * $j] 4 p${j}_rx_section_full
	HSB::dump_reg lbb [expr 0xB1068 + 0x400 * $j] 4 p${j}_tx_section_empty
	HSB::dump_reg lbb [expr 0xB106c + 0x400 * $j] 4 p${j}_tx_section_full
	HSB::dump_reg lbb [expr 0xB1070 + 0x400 * $j] 4 p${j}_rx_almost_empty
	HSB::dump_reg lbb [expr 0xB1074 + 0x400 * $j] 4 p${j}_rx_almost_full
	HSB::dump_reg lbb [expr 0xB1078 + 0x400 * $j] 4 p${j}_tx_almost_empty
	HSB::dump_reg lbb [expr 0xB107c + 0x400 * $j] 4 p${j}_tx_almost_full
	HSB::dump_reg lbb [expr 0xB1080 + 0x400 * $j] 4 p${j}_tx_cmd_stat

	HSB::dump_reg lbb [expr 0xB10D0 + 0x400 * $j] 4 p${j}_tx_valid_frm_cnt
	HSB::dump_reg lbb [expr 0xB10D4 + 0x400 * $j] 4 p${j}_rx_valid_frm_cnt
	HSB::dump_reg lbb [expr 0xB10D8 + 0x400 * $j] 4 p${j}_rx_crc_errs
	HSB::dump_reg lbb [expr 0xB10DC + 0x400 * $j] 4 p${j}_rx_align_errs
	HSB::dump_reg lbb [expr 0xB10E0 + 0x400 * $j] 4 p${j}_tx_valid_byte_cnt_lo
	HSB::dump_reg lbb [expr 0xB10E4 + 0x400 * $j] 4 p${j}_tx_valid_byte_cnt_hi
	HSB::dump_reg lbb [expr 0xB10E8 + 0x400 * $j] 4 p${j}_rx_valid_byte_cnt_lo
	HSB::dump_reg lbb [expr 0xB10EC + 0x400 * $j] 4 p${j}_rx_valid_byte_cnt_hi
	HSB::dump_reg lbb [expr 0xB10F0 + 0x400 * $j] 4 p${j}_tx_pause_frm_cnt
	HSB::dump_reg lbb [expr 0xB10F4 + 0x400 * $j] 4 p${j}_rx_pause_frm_cnt
	HSB::dump_reg lbb [expr 0xB10F8 + 0x400 * $j] 4 p${j}_rx_err_frm_cnt
	HSB::dump_reg lbb [expr 0xB10FC + 0x400 * $j] 4 p${j}_tx_err_frm_cnt
	HSB::dump_reg lbb [expr 0xB1100 + 0x400 * $j] 4 p${j}_rx_uni_frm_cnt
	HSB::dump_reg lbb [expr 0xB1104 + 0x400 * $j] 4 p${j}_rx_multi_frm_cnt
	HSB::dump_reg lbb [expr 0xB1108 + 0x400 * $j] 4 p${j}_rx_bcast_frm_cnt
	HSB::dump_reg lbb [expr 0xB110c + 0x400 * $j] 4 p${j}_tx_uni_frm_cnt
	HSB::dump_reg lbb [expr 0xB1110 + 0x400 * $j] 4 p${j}_tx_multi_frm_cnt
	HSB::dump_reg lbb [expr 0xB1114 + 0x400 * $j] 4 p${j}_tx_bcast_frm_cnt
	HSB::dump_reg lbb [expr 0xB1118 + 0x400 * $j] 4 p${j}_drop_mac_err
	HSB::dump_reg lbb [expr 0xB111c + 0x400 * $j] 4 p${j}_rx_all_byte_cnt_lo
	HSB::dump_reg lbb [expr 0xB1120 + 0x400 * $j] 4 p${j}_rx_all_byte_cnt_hi
	HSB::dump_reg lbb [expr 0xB1124 + 0x400 * $j] 4 p${j}_rx_all_frm_cnt
	HSB::dump_reg lbb [expr 0xB1128 + 0x400 * $j] 4 p${j}_rx_undersz_frm_cnt
	HSB::dump_reg lbb [expr 0xB112c + 0x400 * $j] 4 p${j}_rx_oversz_frm_cnt
	HSB::dump_reg lbb [expr 0xB1130 + 0x400 * $j] 4 p${j}_rx_64byte_frm_cnt
	HSB::dump_reg lbb [expr 0xB1134 + 0x400 * $j] 4 p${j}_rx_64_127_frm_cnt
	HSB::dump_reg lbb [expr 0xB1138 + 0x400 * $j] 4 p${j}_rx_128_255_frm_cnt
	HSB::dump_reg lbb [expr 0xB113c + 0x400 * $j] 4 p${j}_rx_256_511_frm_cnt
	HSB::dump_reg lbb [expr 0xB1140 + 0x400 * $j] 4 p${j}_rx_512_1023_frm_cnt
	HSB::dump_reg lbb [expr 0xB1144 + 0x400 * $j] 4 p${j}_rx_1024_1518_frm_cnt
	HSB::dump_reg lbb [expr 0xB1148 + 0x400 * $j] 4 p${j}_rx_1519_frm_cnt
	HSB::dump_reg lbb [expr 0xB114c + 0x400 * $j] 4 p${j}_rx_jabber_frm_cnt
	HSB::dump_reg lbb [expr 0xB1150 + 0x400 * $j] 4 p${j}_rx_frag_frm_cnt

	HSB::dump_reg lbb [expr 0xB1190 + 0x400 * $j] 4 p${j}_ertx_1g_phy_ctrl
	HSB::dump_reg lbb [expr 0xB1194 + 0x400 * $j] 4 p${j}_ertx_1g_phy_stat
	HSB::dump_reg lbb [expr 0xB1198 + 0x400 * $j] 4 p${j}_ertx_1g_phy_id0
	HSB::dump_reg lbb [expr 0xB119c + 0x400 * $j] 4 p${j}_ertx_1g_phy_id1
	HSB::dump_reg lbb [expr 0xB11A0 + 0x400 * $j] 4 p${j}_ertx_1g_phy_tmr0
	HSB::dump_reg lbb [expr 0xB11A4 + 0x400 * $j] 4 p${j}_ertx_1g_phy_tmr1
	HSB::dump_reg lbb [expr 0xB11A8 + 0x400 * $j] 4 p${j}_ertx_1g_ifmode
	HSB::dump_reg lbb [expr 0xB11Ac + 0x400 * $j] 4 p${j}_ertx_clr_1g
	HSB::dump_reg lbb [expr 0xB11B0 + 0x400 * $j] 4 p${j}_ertx_1g_drop
	HSB::dump_reg lbb [expr 0xB11B4 + 0x400 * $j] 4 p${j}_1g_saf_debug
	HSB::dump_reg lbb [expr 0xB11B8 + 0x400 * $j] 4 p${j}_saf_tx_level
	HSB::dump_reg lbb [expr 0xB11Bc + 0x400 * $j] 4 p${j}_saf_rx_level
	HSB::dump_reg lbb [expr 0xB11C0 + 0x400 * $j] 4 p${j}_saf_tx_write
	HSB::dump_reg lbb [expr 0xB11C4 + 0x400 * $j] 4 p${j}_saf_rx_write
	HSB::dump_reg lbb [expr 0xB11C8 + 0x400 * $j] 4 p${j}_saf_tx_read
	HSB::dump_reg lbb [expr 0xB11CC + 0x400 * $j] 4 p${j}_saf_rx_read

	for { set k 0x1d0 } {$k < 0x1fd} {incr k 4} {
		HSB::dump_reg lbb [expr 0xB1000 + 0x400 * $j + $k] 4 p${j}_${k}_saf_debug
	}
    }

    # 10G port registers
    set i 4
    for { set j 0} {$j < 2} {incr j 1} {
	HSB::dump_reg lbb [expr 0xB5000 + 0x400 * $j] 4 p${i}_10g_ertx_reset
	HSB::dump_reg lbb [expr 0xB5004 + 0x400 * $j] 4 p${i}_phy_status
	HSB::dump_reg lbb [expr 0xB5008 + 0x400 * $j] 4 p${i}_port_vlan
	HSB::dump_reg lbb [expr 0xB500C + 0x400 * $j] 4 p${i}_sfp_cntrl
	HSB::dump_reg lbb [expr 0xB5010 + 0x400 * $j] 4 p${i}_tx_flow_cntrl
	HSB::dump_reg lbb [expr 0xB5014 + 0x400 * $j] 4 p${i}_flow_cntrl

	#0x018 thru 0x0x3c
	for { set k 0x18 } {$k < 0x3d} {incr k 4} {
		HSB::dump_reg lbb [expr 0xB5000 + 0x400 * $j + $k] 4 p${i}__${k}_10g_resv
	}
	HSB::dump_reg lbb [expr 0xB5040 + 0x400 * $j] 4 p${i}_rx_control
	HSB::dump_reg lbb [expr 0xB5044 + 0x400 * $j] 4 p${i}_rx_status
	HSB::dump_reg lbb [expr 0xB5048 + 0x400 * $j] 4 p${i}_rx_pad_control
	HSB::dump_reg lbb [expr 0xB504C + 0x400 * $j] 4 p${i}_crc_checker
	HSB::dump_reg lbb [expr 0xB5050 + 0x400 * $j] 4 p${i}_rx_max_frame_len
	HSB::dump_reg lbb [expr 0xB5054 + 0x400 * $j] 4 p${i}_tx_control
	HSB::dump_reg lbb [expr 0xB5058 + 0x400 * $j] 4 p${i}_tx_status
	HSB::dump_reg lbb [expr 0xB505C + 0x400 * $j] 4 p${i}_tx_pad
	HSB::dump_reg lbb [expr 0xB5060 + 0x400 * $j] 4 p${i}_tx_crcins_cntrl
	HSB::dump_reg lbb [expr 0xB5064 + 0x400 * $j] 4 p${i}_tx_pause_control
	HSB::dump_reg lbb [expr 0xB5068 + 0x400 * $j] 4 p${i}_tx_pause_quanta
	HSB::dump_reg lbb [expr 0xB506C + 0x400 * $j] 4 p${i}_tx_pause_enable
	HSB::dump_reg lbb [expr 0xB5070 + 0x400 * $j] 4 p${i}_tx_max_frame_len
	HSB::dump_reg lbb [expr 0xB5074 + 0x400 * $j] 4 p${i}_rx_clr_stats
	HSB::dump_reg lbb [expr 0xB5078 + 0x400 * $j] 4 p${i}_tx_clr_stats
	HSB::dump_reg lbb [expr 0xB507C + 0x400 * $j] 4 p${i}_rx_frame_ctrl
	HSB::dump_reg lbb [expr 0xB5080 + 0x400 * $j] 4 p${i}_rx_frame_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5084 + 0x400 * $j] 4 p${i}_rx_frame_cnt_upr
	HSB::dump_reg lbb [expr 0xB5088 + 0x400 * $j] 4 p${i}_tx_frame_cnt_lwr
	HSB::dump_reg lbb [expr 0xB508C + 0x400 * $j] 4 p${i}_tx_frame_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5090 + 0x400 * $j] 4 p${i}_rx_crc_err_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5094 + 0x400 * $j] 4 p${i}_rx_crc_err_cnt_upr
	HSB::dump_reg lbb [expr 0xB5098 + 0x400 * $j] 4 p${i}_tx_crc_err_cnt_lwr
	HSB::dump_reg lbb [expr 0xB509C + 0x400 * $j] 4 p${i}_tx_crc_err_cnt_upr
	HSB::dump_reg lbb [expr 0xB50A0 + 0x400 * $j] 4 p${i}_rx_valid_byt_cnt_lwr
	HSB::dump_reg lbb [expr 0xB50A4 + 0x400 * $j] 4 p${i}_rx_valid_byt_cnt_upr
	HSB::dump_reg lbb [expr 0xB50A8 + 0x400 * $j] 4 p${i}_tx_valid_byt_cnt_lwr
	HSB::dump_reg lbb [expr 0xB50AC + 0x400 * $j] 4 p${i}_tx_valid_byt_cnt_upr
	HSB::dump_reg lbb [expr 0xB50B0 + 0x400 * $j] 4 p${i}_rx_ps_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB50B4 + 0x400 * $j] 4 p${i}_rx_ps_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB50B8 + 0x400 * $j] 4 p${i}_tx_ps_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB50BC + 0x400 * $j] 4 p${i}_tx_ps_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB50C0 + 0x400 * $j] 4 p${i}_rx_bad_err_cnt_lwr
	HSB::dump_reg lbb [expr 0xB50C4 + 0x400 * $j] 4 p${i}_rx_bad_err_cnt_upr
	HSB::dump_reg lbb [expr 0xB50C8 + 0x400 * $j] 4 p${i}_tx_bad_err_cnt_lwr
	HSB::dump_reg lbb [expr 0xB50CC + 0x400 * $j] 4 p${i}_tx_bad_err_cnt_upr
	HSB::dump_reg lbb [expr 0xB50D0 + 0x400 * $j] 4 p${i}_rx_ucast_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB50D4 + 0x400 * $j] 4 p${i}_rx_ucast_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB50D8 + 0x400 * $j] 4 p${i}_tx_ucast_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB50DC + 0x400 * $j] 4 p${i}_tx_ucast_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB50E0 + 0x400 * $j] 4 p${i}_rx_mcast_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB50E4 + 0x400 * $j] 4 p${i}_rx_mcast_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB50E8 + 0x400 * $j] 4 p${i}_tx_mcast_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB50EC + 0x400 * $j] 4 p${i}_tx_mcast_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB50F0 + 0x400 * $j] 4 p${i}_rx_bcast_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB50F4 + 0x400 * $j] 4 p${i}_rx_bcast_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB50F8 + 0x400 * $j] 4 p${i}_tx_bcast_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB50FC + 0x400 * $j] 4 p${i}_tx_bcast_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5100 + 0x400 * $j] 4 p${i}_rx_all_byte_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5104 + 0x400 * $j] 4 p${i}_rx_all_byte_cnt_upr
	HSB::dump_reg lbb [expr 0xB5108 + 0x400 * $j] 4 p${i}_tx_all_byte_cnt_lwr
	HSB::dump_reg lbb [expr 0xB510C + 0x400 * $j] 4 p${i}_tx_all_byte_cnt_upr
	HSB::dump_reg lbb [expr 0xB5110 + 0x400 * $j] 4 p${i}_rx_all_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5114 + 0x400 * $j] 4 p${i}_rx_all_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5118 + 0x400 * $j] 4 p${i}_tx_all_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB511C + 0x400 * $j] 4 p${i}_tx_all_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5120 + 0x400 * $j] 4 p${i}_rx_usize_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5124 + 0x400 * $j] 4 p${i}_rx_usize_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5128 + 0x400 * $j] 4 p${i}_tx_usize_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB512C + 0x400 * $j] 4 p${i}_tx_usize_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5130 + 0x400 * $j] 4 p${i}_rx_osize_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5134 + 0x400 * $j] 4 p${i}_rx_osize_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5138 + 0x400 * $j] 4 p${i}_tx_osize_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB513C + 0x400 * $j] 4 p${i}_tx_osize_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5140 + 0x400 * $j] 4 p${i}_rx_64_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5144 + 0x400 * $j] 4 p${i}_rx_64_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5148 + 0x400 * $j] 4 p${i}_tx_64_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB514C + 0x400 * $j] 4 p${i}_tx_64_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5150 + 0x400 * $j] 4 p${i}_rx_65_127_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5154 + 0x400 * $j] 4 p${i}_rx_65_127_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5158 + 0x400 * $j] 4 p${i}_tx_65_127_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB515C + 0x400 * $j] 4 p${i}_tx_65_127_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5160 + 0x400 * $j] 4 p${i}_rx_128_255_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5164 + 0x400 * $j] 4 p${i}_rx_128_255_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5168 + 0x400 * $j] 4 p${i}_tx_128_255_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB516C + 0x400 * $j] 4 p${i}_tx_128_255_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5170 + 0x400 * $j] 4 p${i}_rx_256_511_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5174 + 0x400 * $j] 4 p${i}_rx_256_511_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5178 + 0x400 * $j] 4 p${i}_tx_256_511_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB517C + 0x400 * $j] 4 p${i}_tx_256_511_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5180 + 0x400 * $j] 4 p${i}_rx_512_1023_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5184 + 0x400 * $j] 4 p${i}_rx_512_1023_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5188 + 0x400 * $j] 4 p${i}_tx_512_1023_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB518C + 0x400 * $j] 4 p${i}_tx_512_1023_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5190 + 0x400 * $j] 4 p${i}_rx_1024_1518_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5194 + 0x400 * $j] 4 p${i}_rx_1024_1518_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB5198 + 0x400 * $j] 4 p${i}_tx_1024_1518_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB519C + 0x400 * $j] 4 p${i}_tx_1024_1518_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB51A0 + 0x400 * $j] 4 p${i}_rx_ovr_1519_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB51A4 + 0x400 * $j] 4 p${i}_rx_ovr_1519_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB51A8 + 0x400 * $j] 4 p${i}_tx_ovr_1519_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB51AC + 0x400 * $j] 4 p${i}_tx_ovr_1519_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB51B0 + 0x400 * $j] 4 p${i}_rx_frag_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB51B4 + 0x400 * $j] 4 p${i}_rx_frag_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB51B8 + 0x400 * $j] 4 p${i}_tx_frag_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB51BC + 0x400 * $j] 4 p${i}_tx_frag_frm_cnt_upr

	HSB::dump_reg lbb [expr 0xB51C0 + 0x400 * $j] 4 p${i}_rx_jabber_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB51C4 + 0x400 * $j] 4 p${i}_rx_jabber_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB51C8 + 0x400 * $j] 4 p${i}_tx_jabber_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB51CC + 0x400 * $j] 4 p${i}_tx_jabber_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB51D0 + 0x400 * $j] 4 p${i}_rx_allcrc_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB51D4 + 0x400 * $j] 4 p${i}_rx_allcrc_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB51D8 + 0x400 * $j] 4 p${i}_tx_allcrc_frm_cnt_lwr
	HSB::dump_reg lbb [expr 0xB51dC + 0x400 * $j] 4 p${i}_tx_allcrc_frm_cnt_upr
	HSB::dump_reg lbb [expr 0xB51E0 + 0x400 * $j] 4 p${i}_rx_ucast_ctrl_cnt_lwr
	HSB::dump_reg lbb [expr 0xB51E4 + 0x400 * $j] 4 p${i}_rx_ucast_ctrl_cnt_upr
	HSB::dump_reg lbb [expr 0xB51E8 + 0x400 * $j] 4 p${i}_tx_ucast_ctrl_cnt_lwr
	HSB::dump_reg lbb [expr 0xB51EC + 0x400 * $j] 4 p${i}_tx_ucast_ctrl_cnt_upr
	HSB::dump_reg lbb [expr 0xB51F0 + 0x400 * $j] 4 p${i}_rx_mcast_ctrl_cnt_lwr
	HSB::dump_reg lbb [expr 0xB51F4 + 0x400 * $j] 4 p${i}_rx_mcast_ctrl_cnt_upr
	HSB::dump_reg lbb [expr 0xB51F8 + 0x400 * $j] 4 p${i}_tx_mcast_ctrl_cnt_lwr
	HSB::dump_reg lbb [expr 0xB51FC + 0x400 * $j] 4 p${i}_tx_mcast_ctrl_cnt_upr
	HSB::dump_reg lbb [expr 0xB5200 + 0x400 * $j] 4 p${i}_rx_bcast_ctrl_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5204 + 0x400 * $j] 4 p${i}_rx_bcast_ctrl_cnt_upr
	HSB::dump_reg lbb [expr 0xB5208 + 0x400 * $j] 4 p${i}_tx_bcast_ctrl_cnt_lwr
	HSB::dump_reg lbb [expr 0xB520c + 0x400 * $j] 4 p${i}_tx_bcast_ctrl_cnt_upr
	HSB::dump_reg lbb [expr 0xB5210 + 0x400 * $j] 4 p${i}_rx_pfc_ctrl_cnt_lwr
	HSB::dump_reg lbb [expr 0xB5214 + 0x400 * $j] 4 p${i}_rx_pfc_ctrl_cnt_upr
	HSB::dump_reg lbb [expr 0xB5218 + 0x400 * $j] 4 p${i}_tx_pfc_ctrl_cnt_lwr
	HSB::dump_reg lbb [expr 0xB521c + 0x400 * $j] 4 p${i}_tx_pfc_ctrl_cnt_upr

	HSB::dump_reg lbb [expr 0xB5240 + 0x400 * $j] 4 p${i}_tx_pll_locked
	HSB::dump_reg lbb [expr 0xB5244 + 0x400 * $j] 4 p${i}_phy_reset
	HSB::dump_reg lbb [expr 0xB5248 + 0x400 * $j] 4 p${i}_phy_serial_lb
	HSB::dump_reg lbb [expr 0xB524c + 0x400 * $j] 4 p${i}_pma_rx_set_lockdata
	HSB::dump_reg lbb [expr 0xB5250 + 0x400 * $j] 4 p${i}_pma_rx_set_lockref
	HSB::dump_reg lbb [expr 0xB5254 + 0x400 * $j] 4 p${i}_pma_rx_locktodata
	HSB::dump_reg lbb [expr 0xB5258 + 0x400 * $j] 4 p${i}_pma_rx_locktoref
	HSB::dump_reg lbb [expr 0xB525c + 0x400 * $j] 4 p${i}_pcs_errblk_clr
	HSB::dump_reg lbb [expr 0xB5260 + 0x400 * $j] 4 p${i}_psc_err_stat
	HSB::dump_reg lbb [expr 0xB5264 + 0x400 * $j] 4 p${i}_ertx_clear_10g
	HSB::dump_reg lbb [expr 0xB5268 + 0x400 * $j] 4 p${i}_saf_debug_status
	HSB::dump_reg lbb [expr 0xB526C + 0x400 * $j] 4 p${i}_ertx_drop_cnt
	HSB::dump_reg lbb [expr 0xB5270 + 0x400 * $j] 4 p${i}_saf_tx_level
	HSB::dump_reg lbb [expr 0xB5274 + 0x400 * $j] 4 p${i}_saf_rx_level
	HSB::dump_reg lbb [expr 0xB5278 + 0x400 * $j] 4 p${i}_saf_tx_write_cnt
	HSB::dump_reg lbb [expr 0xB527C + 0x400 * $j] 4 p${i}_SAF_rx_write_cnt
	HSB::dump_reg lbb [expr 0xB5280 + 0x400 * $j] 4 p${i}_saf_tx_read_cnt
	HSB::dump_reg lbb [expr 0xB5284 + 0x400 * $j] 4 p${i}_saf_rx_read_cnt

	 # 0xB5288 thru 0x2ff
	for { set k 0x288 } {$k < 0x2fd} {incr k 4} {
		HSB::dump_reg lbb [expr 0xB5000 + 0x400 * $j + $k] 4 p${i}_${k}_10g_rsvd
	}

	incr i 1
    }

    # dqm debug
    HSB::dump_reg lbb 0xc0000 4 dqm_status
    HSB::dump_reg lbb 0xc0004 4 dqm_jumbo_drp_flags
    HSB::dump_reg lbb 0xc0008 4 dqm_return_pkt_multi_desc_seg_limit

    HSB::dump_reg lbb 0xc0204 4 dqm_dq_hde0_dbg
    HSB::dump_reg lbb 0xc0208 4 dqm_dq_hde0_dbg_1
    HSB::dump_reg lbb 0xc020c 4 dqm_dq_hde1_dbg
    HSB::dump_reg lbb 0xc0210 4 dqm_dq_hde1_dbg_1
    HSB::dump_reg lbb 0xc0214 4 dqm_tre_dbg
    HSB::dump_reg lbb 0xc0218 4 dqm_enq0_dbg
    HSB::dump_reg lbb 0xc021c 4 dqm_enq1_dbg
    HSB::dump_reg lbb 0xc0220 4 dqm_stat_dbg
    HSB::dump_reg lbb 0xc0224 4 dqm_enq0_drp_dbg
    HSB::dump_reg lbb 0xc0228 4 dqm_enq1_drp_dbg
    HSB::dump_reg lbb 0xc022c 4 dqm_fc_dbg
    HSB::dump_reg lbb 0xc0230 4 dqm_ring0_lwr_dbg
    HSB::dump_reg lbb 0xc0234 4 dqm_ring0_upr_dbg
    HSB::dump_reg lbb 0xc0238 4 dqm_ring1_lwr_dbg
    HSB::dump_reg lbb 0xc023c 4 dqm_ring1_upr_dbg
    HSB::dump_reg lbb 0xc0240 4 dqm_dbg_0
    HSB::dump_reg lbb 0xc0244 4 dqm_dbg_1
    HSB::dump_reg lbb 0xc0248 4 dqm_dbg_2
    HSB::dump_reg lbb 0xc024c 4 dqm_dbg_3
    HSB::dump_reg lbb 0xc0250 4 dqm_dbg_4
    HSB::dump_reg lbb 0xc0254 4 dqm_dbg_5
    HSB::dump_reg lbb 0xc0258 4 dqm_dbg_6
    HSB::dump_reg lbb 0xc025c 4 dqm_dbg_7

    # dqm hgm stats
    for { set j 0 } {$j < 6} {incr j 1} {
	HSB::dump_reg lbb [expr 0xc0400 + 0x20 * $j] 4 dqm_hgm_fwd_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0xc0404 + 0x20 * $j] 4 dqm_hgm_fwd_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0xc0408 + 0x20 * $j] 4 dqm_hgm_fwd_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0xc0410 + 0x20 * $j] 4 dqm_hgm_drp_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0xc0414 + 0x20 * $j] 4 dqm_hgm_drp_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0xc0418 + 0x20 * $j] 4 dqm_hgm_drp_byte_cnt_lsb_${j}
    }

    # 96 DQM PDE Queues
    for { set j 0 } {$j < 96} {incr j 1} {
	HSB::dump_reg lbb [expr 0xc0800 + 32 * $j] 4 dqm_pde_fwd_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0xc0804 + 32 * $j] 4 dqm_pde_fwd_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0xc0808 + 32 * $j] 4 dqm_pde_fwd_byte_cnt_lsb_${j}
	HSB::dump_reg lbb [expr 0xc080c + 32 * $j] 4 dqm_pde_fwd_clr_${j}
	HSB::dump_reg lbb [expr 0xc0810 + 32 * $j] 4 dqm_pde_drp_pkt_cnt_${j}
	HSB::dump_reg lbb [expr 0xc0814 + 32 * $j] 4 dqm_pde_drp_byte_cnt_msb_${j}
	HSB::dump_reg lbb [expr 0xc0818 + 32 * $j] 4 dqm_pde_drp_byte_cnt_lsb_${j}
    }

    #TXFC debug
    HSB::dump_reg lbb 0xD0000 4 txfc_hde_bcnt_adj
    HSB::dump_reg lbb 0xD0004 4 txfc_dqm_bcnt_adj
    HSB::dump_reg lbb 0xD0008 4 txfc_ertx_bcnt_adj
    HSB::dump_reg lbb 0xD000C 4 txfc_bcnt_limit_p5
    HSB::dump_reg lbb 0xD0010 4 txfc_bcnt_limit_p4
    HSB::dump_reg lbb 0xD0014 4 txfc_bcnt_limit_p3
    HSB::dump_reg lbb 0xD0018 4 txfc_bcnt_limit_p2
    HSB::dump_reg lbb 0xD001C 4 txfc_bcnt_limit_p1
    HSB::dump_reg lbb 0xD0020 4 txfc_bcnt_limit_p0
    HSB::dump_reg lbb 0xD0024 4 txfc_bcnt_p5
    HSB::dump_reg lbb 0xD0028 4 txfc_bcnt_p4
    HSB::dump_reg lbb 0xD002C 4 txfc_bcnt_p3
    HSB::dump_reg lbb 0xD0030 4 txfc_bcnt_p2
    HSB::dump_reg lbb 0xD0034 4 txfc_bcnt_p1
    HSB::dump_reg lbb 0xD0038 4 txfc_bcnt_p0
    HSB::dump_reg lbb 0xD003C 4 txfc_dbg2
    HSB::dump_reg lbb 0xD0040 4 txfc_dbg1
    HSB::dump_reg lbb 0xD0044 4 txfc_dbg0
}

#
# NDMAC
#
HSB::dump_reg lbb 0x3a000 4 ndmac_cache_coherency
HSB::dump_reg lbb 0x3a004 4 ndmac_meta_ring_config
HSB::dump_reg lbb 0x3a008 4 nde_watchdog_timeout

#
# Control/status registers for HSB (High Speed Bridge)'s PDE (Packet DMA Engine)
#
HSB::dump_reg pde 0x00000 4 pde_rx_buf_size
HSB::dump_reg pde 0x00004 4 pde_ht_limit
HSB::dump_reg pde 0x00008 4 pde_cache_coherency_bit_ctrl
HSB::dump_reg pde 0x0000c 4 pde_prod_desc_fifo_lvl
HSB::dump_reg pde 0x00010 4 pde_id

HSB::dump_reg pde 0x00030 4 pde_software_sync
HSB::dump_reg pde 0x00040 4 pde_arb_adjust_cnt

HSB::dump_reg pde 0x00070 4 rate_measurement_control
HSB::dump_reg pde 0x00074 4 rate_measurement_clocks
HSB::dump_reg pde 0x00078 4 rate_measurement_packets

HSB::dump_reg pde 0x0007c 4 pde_tx_packets
HSB::dump_reg pde 0x00080 4 pde_tx_bytes

HSB::dump_reg pde 0x00100 4 pde_prod_ring_def_0
HSB::dump_reg pde 0x00104 4 pde_prod_ring_def_1

for { set j 0 } {$j < 4} {incr j 1} {
    HSB::dump_reg pde [expr 0x00108 + 0x08 * $j] 4 pde_send_ring_${j}_def_0
    HSB::dump_reg pde [expr 0x0010c + 0x08 * $j] 4 pde_send_ring_${j}_def_1
}
for { set j 0 } {$j < 4} {incr j 1} {
    HSB::dump_reg pde [expr 0x00128 + 0x08 * $j] 4 pde_return_ring_${j}_def_0
    HSB::dump_reg pde [expr 0x0012c + 0x08 * $j] 4 pde_return_ring_${j}_def_1
}

HSB::dump_reg pde 0x00148 4 pde_host_status_addr_0
HSB::dump_reg pde 0x0014C 4 pde_host_status_addr_1
HSB::dump_reg pde 0x00150 4 pde_host_coal_ctrl
HSB::dump_reg pde 0x00154 4 pde_cos_map_tbl
HSB::dump_reg pde 0x00158 4 pde_restart_ctrl
HSB::dump_reg pde 0x0015c 4 pde_dma_watchdog_ctrl

HSB::dump_reg pde 0x00160 4 pde_mgmt_ring_def_0
HSB::dump_reg pde 0x00164 4 pde_mgmt_ring_def_1

HSB::dump_reg pde 0x00180 4 pde_prod_ring_prod_index

for { set j 0 } {$j < 4} {incr j 1} {
    HSB::dump_reg pde [expr 0x00184 + 0x04 * $j] 4 pde_send_ring_${j}_prod_idx
}
for { set j 0 } {$j < 4} {incr j 1} {
    HSB::dump_reg pde [expr 0x00194 + 0x04 * $j] 4 pde_return_ring_${j}_cons_idx
}

HSB::dump_reg pde 0x001a4 4 pde_mgmt_ring_cons_idx
HSB::dump_reg pde 0x00200 4 pde_epva_ctrl
HSB::dump_reg pde 0x00280 4 pde_spva_ctrl

HSB::dump_reg pde 0x00300 4 pde_mac_sa_tbl_config_upper
HSB::dump_reg pde 0x00304 4 pde_mac_sa_tbl_config_lower
HSB::dump_reg pde 0x00308 4 pde_mac_sa_tbl_control

HSB::dump_reg pde 0x00330 4 pde_syn_cookie_secret_ctrl_1
HSB::dump_reg pde 0x00334 4 pde_syn_cookie_secret_ctrl_2
HSB::dump_reg pde 0x00338 4 pde_syn_cookie_secret_ctrl_3

for { set j 0 } {$j < 4} {incr j 1} {
    HSB::dump_reg pde [expr 0x00400 + 0x04 * $j] 4 pde_return_ring_${j}_packet_drop_count
}

HSB::dump_reg pde 0x00410 4 pde_dprq_dbg
HSB::dump_reg pde 0x00414 4 pde_rsp_dbg
HSB::dump_reg pde 0x00418 4 pde_prq_dbg
HSB::dump_reg pde 0x0041c 4 pde_readrq_dbg
HSB::dump_reg pde 0x00420 4 pde_readdat_dbg
HSB::dump_reg pde 0x00424 4 pde_write_dbg
HSB::dump_reg pde 0x00428 4 pde_descrq_dbg
HSB::dump_reg pde 0x0042c 4 pde_retqmgr_dbg
HSB::dump_reg pde 0x00430 4 pde_rxdescmgr_dbg
HSB::dump_reg pde 0x00434 4 pde_coalesce_dbg
HSB::dump_reg pde 0x00438 4 pde_lcl_cidx_dbg
HSB::dump_reg pde 0x0043c 4 pde_mgr_send_dbg
HSB::dump_reg pde 0x00440 4 pde_mgr_ret_dbg
HSB::dump_reg pde 0x00444 4 pde_ram_dbg
HSB::dump_reg pde 0x00448 4 rxdata_rqst_debug3
HSB::dump_reg pde 0x0044c 4 rxdata_rqst_debug4
HSB::dump_reg pde 0x00450 4 rxwrite_debug
HSB::dump_reg pde 0x00454 4 rx_prod_hsu_debug
HSB::dump_reg pde 0x00458 4 rx_reset_hsu_debug
HSB::dump_reg pde 0x0045c 4 rx_mgmt_hsu_debug
HSB::dump_reg pde 0x00460 4 pdesc_fifo_debug
HSB::dump_reg pde 0x00464 4 pdesc_rqst_debug
HSB::dump_reg pde 0x00468 4 mgmtwrite_debug
HSB::dump_reg pde 0x0046c 4 td_fifo_debug
HSB::dump_reg pde 0x00470 4 cpl_debug

HSB::dump_reg pde 0x00510 4 sdata_rqst_debug
HSB::dump_reg pde 0x00514 4 sdata_wr_debug
HSB::dump_reg pde 0x00518 4 sdesc_fifo_debug
HSB::dump_reg pde 0x0051c 4 sdesc_rqst_debug
HSB::dump_reg pde 0x00520 4 sdesc_rqst_debug2
HSB::dump_reg pde 0x00524 4 sdesc_rqst_debug3
HSB::dump_reg pde 0x00528 4 sdesc_rqst_debug4
HSB::dump_reg pde 0x0052c 4 sdesc_rqst_debug5
HSB::dump_reg pde 0x00530 4 tx_mgmt_hsu_debug
HSB::dump_reg pde 0x00534 4 tx_sring_hsb_debug
HSB::dump_reg pde 0x00538 4 sdata_rqst_debug2
HSB::dump_reg pde 0x0053c 4 sdata_wr_debug2

HSB::dump_reg pde 0x00540 4 rxdata_rqst_debug
HSB::dump_reg pde 0x00544 4 rxdata_rqst_debug2
HSB::dump_reg pde 0x00548 4 rxdata_rqst_debug3
HSB::dump_reg pde 0x0054c 4 rxdata_rqst_debug4
HSB::dump_reg pde 0x00550 4 rxwrite_debug
HSB::dump_reg pde 0x00554 4 rx_prod_hsu_debug
HSB::dump_reg pde 0x00558 4 rx_ret_hsu_debug
HSB::dump_reg pde 0x0055c 4 rx_mgmt_hsu_debug
HSB::dump_reg pde 0x00560 4 pdesc_fifo_debug
HSB::dump_reg pde 0x00564 4 pdesc_rqst_debug
HSB::dump_reg pde 0x00568 4 mgmtwrite_debug
HSB::dump_reg pde 0x0056c 4 rxmgmt_debug
HSB::dump_reg pde 0x00570 4 rxmgmt_debug3

HSB::dump_reg pde 0x00574 4 cpl_debug
HSB::dump_reg pde 0x00578 4 mdesc_rqst_debug
HSB::dump_reg pde 0x0057c 4 mdesc_fifo_debug
HSB::dump_reg pde 0x00580 4 mdata_wr_debug
HSB::dump_reg pde 0x00584 4 mdata_wr_debug2
HSB::dump_reg pde 0x00588 4 td_fifo_debug
HSB::dump_reg pde 0x0058c 4 fad_fifo_debug
HSB::dump_reg pde 0x00590 4 neuron_fifo_debug

HSB::dump_reg pde 0x04100 4 dos_vec_en0_31
HSB::dump_reg pde 0x04104 4 dos_vec_en32_63
HSB::dump_reg pde 0x04108 4 dos_vec_en64_95
HSB::dump_reg pde 0x0410c 4 dos_vec_en96_127
HSB::dump_reg pde 0x10100 4 pde_send_ring_4_def_0
HSB::dump_reg pde 0x10104 4 pde_send_ring_4_def_1
HSB::dump_reg pde 0x10108 4 pde_send_ring_5_def_0
HSB::dump_reg pde 0x1010c 4 pde_send_ring_5_def_1
HSB::dump_reg pde 0x10200 4 pde_return_ring_4_def_0
HSB::dump_reg pde 0x10204 4 pde_return_ring_4_def_1
HSB::dump_reg pde 0x10208 4 pde_return_ring_5_def_0
HSB::dump_reg pde 0x1020c 4 pde_return_ring_5_def_1
HSB::dump_reg pde 0x10300 4 pde_send_ring_4_prod_idx
HSB::dump_reg pde 0x10304 4 pde_send_ring_5_prod_idx
HSB::dump_reg pde 0x10400 4 pde_return_ring_4_cons_idx
HSB::dump_reg pde 0x10404 4 pde_return_ring_5_cons_idx

HSB::dump_reg pde 0x0440c 4 pde_global_syn_enable
HSB::dump_reg pde 0x04410 4 pde_global_syn_transform
HSB::dump_reg pde 0x04414 4 pde_global_syn_ack_counter

set SRAM_36_MB  18
set SRAM_72_MB  19
set SRAM_144_MB 20

if { [string compare $platform "A108"] == 0 } {
    HSBE::rqm_sram_size "hsb_lbb0" $SRAM_72_MB
    HSBE::epva_sram_size "hsb_lbb0" $SRAM_72_MB
    HSBE::rqm_sram_size "hsb_lbb1" $SRAM_72_MB
    HSBE::epva_sram_size "hsb_lbb1" $SRAM_72_MB
} elseif { [string compare $platform "A109"] == 0 } {
    HSBE::rqm_sram_size "hsb_lbb0" $SRAM_36_MB
    HSBE::epva_sram_size "hsb_lbb0" $SRAM_72_MB
} elseif { [string compare $platform "A110"] == 0 } {
    HSBE::rqm_sram_size "hsb_lbb0" $SRAM_72_MB
    HSBE::epva_sram_size "hsb_lbb0" $SRAM_72_MB
    HSBE::rqm_sram_size "hsb_lbb1" $SRAM_72_MB
    HSBE::epva_sram_size "hsb_lbb1" $SRAM_72_MB
} elseif { [string compare $platform "A112"] == 0 } {
    HSBE::rqm_sram_size "hsb_lbb0" $SRAM_72_MB
    HSBE::epva_sram_size "hsb_lbb0" $SRAM_144_MB
} elseif { [string compare $platform "A113"] == 0 } {
    HSBE::rqm_sram_size "hsb_lbb0" $SRAM_36_MB
    HSBE::epva_sram_size "hsb_lbb0" $SRAM_72_MB
} elseif { [string compare $platform "A114"] == 0 } {
    HSBE::rqm_sram_size "hsb_lbb0" $SRAM_72_MB
    HSBE::epva_sram_size "hsb_lbb0" $SRAM_144_MB
    HSBE::rqm_sram_size "hsb_lbb1" $SRAM_72_MB
    HSBE::epva_sram_size "hsb_lbb1" $SRAM_144_MB
} elseif { [string compare $platform "C109"] == 0 } {
    HSBE::rqm_sram_size "hsb_lbb0" $SRAM_72_MB
    HSBE::epva_sram_size "hsb_lbb0" $SRAM_72_MB
} elseif { [string compare $platform "D110"] == 0 } {
    HSBE::rqm_sram_size "hsb_lbb0" $SRAM_72_MB
    HSBE::epva_sram_size "hsb_lbb0" $SRAM_72_MB
} elseif { [string compare $platform "D111"] == 0 ||
           [string compare $platform "D112"] == 0 ||
           [string compare $platform "D113"] == 0 } {
    HSBE::rqm_sram_size "hsb_lbb0" $SRAM_72_MB
    HSBE::epva_sram_size "hsb_lbb0" $SRAM_72_MB
    HSBE::rqm_sram_size "hsb_lbb1" $SRAM_72_MB
    HSBE::epva_sram_size "hsb_lbb1" $SRAM_72_MB
}

#
# NDE registers
#

HSB::dump_reg nde 0x0000 4 nde_id_num
HSB::dump_reg nde 0x0004 4 nde_scratch

HSB::dump_reg nde 0x0100 4 nde_meta_ring_0_rde_0
HSB::dump_reg nde 0x0104 4 nde_meta_ring_0_rde_1
HSB::dump_reg nde 0x0108 4 nde_meta_ring_1_rde_0
HSB::dump_reg nde 0x010c 4 nde_meta_ring_1_rde_1

HSB::dump_reg nde 0x0140 4 nde_act_ring_0_rde_0
HSB::dump_reg nde 0x0144 4 nde_act_ring_0_rde_1
HSB::dump_reg nde 0x0148 4 nde_act_ring_1_rde_0
HSB::dump_reg nde 0x014c 4 nde_act_ring_1_rde_1

HSB::dump_reg nde 0x0160 4 nde_host_stat_block_addr_0
HSB::dump_reg nde 0x0164 4 nde_host_stat_block_addr_1

HSB::dump_reg nde 0x0168 4 nde_host_coalescing_cntl
HSB::dump_reg nde 0x0170 4 nde_dma_restart_cntl
HSB::dump_reg nde 0x0170 4 nde_dma_watchdog_cntl

HSB::dump_reg nde 0x0200 4 nde_meta_ring0_cons_idx
HSB::dump_reg nde 0x0204 4 nde_meta_ring1_cons_idx

HSB::dump_reg nde 0x0208 4 nde_act_ring0_prod_idx
HSB::dump_reg nde 0x020c 4 nde_act_ring1_prod_idx
# Disable these for Atlantis
if { ([string compare $platform "C115"] == 0) ||
     ([string compare $platform "C117"] == 0) ||
     ([string compare $platform "C120"] == 0) } {
    HSB::enable_rx_watchdog no
    HSB::enable_qos no
}
