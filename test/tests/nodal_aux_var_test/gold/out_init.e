CDF      
      
len_string     !   len_line   Q   four      	time_step          len_name   !   num_dim       	num_nodes         num_elem   	   
num_el_blk        num_node_sets         num_side_sets         num_el_in_blk1     	   num_nod_per_el1       num_side_ss1      
num_df_ss1        num_side_ss2      
num_df_ss2        num_side_ss3      
num_df_ss3        num_side_ss4      
num_df_ss4        num_nod_ns1       num_nod_ns2       num_nod_ns3       num_nod_ns4       num_nod_var       num_info   �         api_version       @��H   version       @��H   floating_point_word_size            	file_size               title         out_init.e     maximum_name_length                 %   
time_whole                            M   	eb_status                             
$   eb_prop1               name      ID              
(   	ns_status         	                    
,   ns_prop1      	         name      ID              
<   	ss_status         
                    
L   ss_prop1      
         name      ID              
\   coordx                      �      
l   coordy                      �      
�   coordz                      �      l   eb_names                       $      �   ns_names      	                 �         ss_names      
                 �      �   
coor_names                         d         connect1                  	elem_type         QUAD4         �      |   elem_num_map                    $         elem_ss1                          0   side_ss1                          <   dist_fact_ss1                              H   elem_ss2                          h   side_ss2                          t   dist_fact_ss2                              �   elem_ss3                          �   side_ss3                          �   dist_fact_ss3                              �   elem_ss4                          �   side_ss4                          �   dist_fact_ss4                              �   node_ns1                             node_ns2                              node_ns3                          0   node_ns4                          @   vals_nod_var1                          �      M    vals_nod_var2                          �      M�   vals_nod_var3                          �      N    name_nod_var                       d      P   info_records                      =d      �                                                                 ?�UUUUUU?�UUUUUU        ?�UUUUUU?�UUUUUU?�      ?�      ?�UUUUUU        ?�UUUUUU?�      ?�UUUUUU        ?�UUUUUU?�                      ?�UUUUUU?�UUUUUU        ?�UUUUUU        ?�UUUUUU?�UUUUUU?�UUUUUU?�UUUUUU?�UUUUUU?�      ?�      ?�      ?�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   	   
            	               
   	         	                                                	                                                                                                             	                                                  	                                                              
                           u                                aux1                             aux2                              ####################@      @      @      @      @      @      @       @    # Created by MOOSE #       @       @       @       @       @       @       @     ####################      @       @      @      @      @      @      @     ### Command Line Arguments ###   @      @      @      @      @      @      -i                                                                               nodal_aux_init_test.i                                                                                                                                             ### Input File ###                                                                                                                                                                                                                                 [Mesh]                                                                             second_order                   = 0                                               uniform_refine                 = 0                                               file                           = '(no file supplied)'                            nemesis                        = 0                                               patch_size                     = 40                                              skip_partitioning              = 0                                                                                                                                [./Generation]                                                                     dim                          = 2                                                 nx                           = 3                                                 ny                           = 3                                                 nz                           = 1                                                 xmax                         = 1                                                 xmin                         = 0                                                 ymax                         = 1                                                 ymin                         = 0                                                 zmax                         = 1                                                 zmin                         = 0                                               [../]                                                                          []                                                                                                                                                                [Variables]                                                                        [./u]                                                                              initial_from_file_timestep   = 2                                                 family                       = LAGRANGE                                          initial_condition            = 5                                                 order                        = FIRST                                             scaling                      = 1                                               [../]                                                                          []                                                                                                                                                                [AuxVariables]                                                                     [./aux1]                                                                           family                       = LAGRANGE                                          initial_condition            = 2                                                 order                        = FIRST                                             scaling                      = 1                                               [../]                                                                                                                                                             [./aux2]                                                                           family                       = LAGRANGE                                          initial_condition            = 0                                                 order                        = FIRST                                             scaling                      = 1                                                 initial_from_file_timestep   = 2                                               [../]                                                                                                                                                             [./aux1]                                                                           initial_from_file_timestep   = 2                                               [../]                                                                          []                                                                                                                                                                [Kernels]                                                                          [./ie]                                                                             type                         = TimeDerivative                                    execute_on                   = residual                                          start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      variable                     = u                                               [../]                                                                                                                                                             [./diff]                                                                           type                         = Diffusion                                         execute_on                   = residual                                          start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      variable                     = u                                               [../]                                                                                                                                                             [./force]                                                                          type                         = CoupledForce                                      execute_on                   = residual                                          start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      v                            = aux2                                              variable                     = u                                               [../]                                                                          []                                                                                                                                                                [AuxKernels]                                                                       [./field]                                                                          type                         = CoupledAux                                        coupled                      = u                                                 execute_on                   = initial                                           value                        = 2                                                 variable                     = aux2                                            [../]                                                                                                                                                             [./constant]                                                                       type                         = ConstantAux                                       execute_on                   = residual                                          value                        = 1                                                 variable                     = aux1                                            [../]                                                                          []                                                                                                                                                                [BCs]                                                                              [./right]                                                                          type                         = DirichletBC                                       boundary                     = 3                                                 execute_on                   = residual                                          value                        = 1                                                 variable                     = u                                               [../]                                                                                                                                                             [./left]                                                                           type                         = DirichletBC                                       boundary                     = 1                                                 execute_on                   = residual                                          value                        = 0                                                 variable                     = u                                               [../]                                                                          []                                                                                                                                                                [Executioner]                                                                      l_abs_step_tol                 = -1                                              l_max_its                      = 10000                                           l_tol                          = 1e-05                                           nl_abs_step_tol                = 1e-50                                           nl_abs_tol                     = 1e-50                                           nl_max_funcs                   = 10000                                           nl_max_its                     = 50                                              nl_rel_step_tol                = 1e-50                                           nl_rel_tol                     = 1e-08                                           no_fe_reinit                   = 0                                               petsc_options                  = -snes_mf_operator                               scheme                         = backward-euler                                  type                           = Transient                                       dt                             = 0.1                                             dtmax                          = 1e+30                                           dtmin                          = 0                                               end_time                       = 1e+30                                           execute_on                     = residual                                        n_startup_steps                = 0                                               num_steps                      = 2                                               ss_check_tol                   = 1e-08                                           ss_tmin                        = 0                                               start_time                     = 0                                               sync_times                     = -1                                              trans_ss_check                 = 0                                             []                                                                                                                                                                [Output]                                                                           exodus                         = 1                                               file_base                      = out_init                                        gmv                            = 0                                               gnuplot_format                 = ps                                              interval                       = 1                                               iteration_plot_start_time      = 1.79769e+308                                    nemesis                        = 0                                               output_displaced               = 0                                               output_initial                 = 1                                               perf_log                       = 1                                               postprocessor_csv              = 0                                               postprocessor_ensight          = 0                                               postprocessor_gnuplot          = 0                                               postprocessor_screen           = 1                                               print_linear_residuals         = 0                                               print_out_info                 = 0                                               show_setup_log_early           = 0                                               tecplot                        = 0                                               tecplot_binary                 = 0                                               xda                            = 0                                             []                                                                                                                                                                [check_integrity]                                                                []                                                                                                                                                                [init_problem]                                                                   []                                                                                                                                                                [no_action]                                                                      []                                                                                                                                                                [setup_dampers]                                                                  []                                                                                                                                                                [setup_quadrature]                                                                 order                          = AUTO                                            type                           = GAUSS                                         []                                                                                                                                                                [no_action]                                                                                @      @      @      @      @      @      @      @      @      @      @      @      @      @      @      @      @       @       @       @       @       @       @       @       @       @       @       @       @       @       @       @       @      @      @      @      @      @      @      @      @      @      @      @      @      @      @      @      ?�������?�  d/V@ꪩB%7@ꪪ?�?�  d/V@UVh�@UUu=�=��@    =��@    @ꪪ�el?�  d/V@UU��Z=��@    @ꪪ?�  d/V@UV%J=��@    ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      @      @      @      @      @      @      @      @      @      @      @      @      @      @      @      @      ?ə�����?�������@	���Z @	��
��?�������@�A��?�@�A��;;���    ;���    @	��$R>?�������@�A���;���    @	��*��?�������@�A�ޘ=;���    ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      ?�      @      @      @      @      @      @      @      @      @      @      @      @      @      @      @      @      