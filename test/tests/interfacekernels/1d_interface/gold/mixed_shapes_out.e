CDF      
      
len_string     !   len_line   Q   four      	time_step          len_name   !   num_dim       	num_nodes         num_elem   
   
num_el_blk        num_node_sets         num_side_sets         num_el_in_blk1        num_nod_per_el1       num_el_in_blk2        num_nod_per_el2       num_side_ss1      num_side_ss2      num_side_ss3      num_side_ss4      num_nod_ns1       num_nod_ns2       num_nod_ns3       num_nod_ns4       num_nod_var       num_info  �         api_version       @�
=   version       @�
=   floating_point_word_size            	file_size               int64_status             title         mixed_shapes_out.e     maximum_name_length                 "   
time_whole                            �   	eb_status                             	�   eb_prop1               name      ID              	�   	ns_status         	                    	�   ns_prop1      	         name      ID              	�   	ss_status         
                    	�   ss_prop1      
         name      ID              	�   coordx                      �      	�   coordy                      �      
�   coordz                      �      @   eb_names                       D      �   ns_names      	                 �      ,   ss_names      
                 �      �   
coor_names                         d      4   node_num_map                    T      �   connect1                  	elem_type         EDGE3         <      �   connect2                  	elem_type         EDGE3         <      (   elem_num_map                    (      d   elem_ss1                          �   side_ss1                          �   elem_ss2                          �   side_ss2                          �   elem_ss3                          �   side_ss3                          �   elem_ss4                          �   side_ss4                          �   node_ns1                          �   node_ns2                          �   node_ns3                          �   node_ns4                          �   vals_nod_var1                          �      �   vals_nod_var2                          �      ��   name_nod_var                       D      �   info_records                      |                                                                              ?ə�����?�������?ٙ�����?�333333?�333333?�      ?陙����?�ffffff?�      ?�������?�333333?񙙙���?�ffffff?�������?�������?�      ?�������?�333333@       ?�ffffff                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      right                            left                             left                             right                            master0_interface                master1_interface                                                                                                                                               	   
                                                                     	      
      
                                                                     	   
         
                  
   
      u                                v                                  ####################                                                             # Created by MOOSE #                                                             ####################                                                             ### Command Line Arguments ###                                                    -i mixed_shapes.i --error --no-gdb-backtrace### Version Info ###                Framework Information:                                                           MOOSE version:           git commit efab6a0ea4 on 2017-10-30                     PETSc Version:           3.7.6                                                   Current Time:            Tue Oct 31 10:32:16 2017                                Executable Timestamp:    Tue Oct 31 10:31:52 2017                                                                                                                                                                                                  ### Input File ###                                                                                                                                                []                                                                                 inactive                       =                                                 initial_from_file_timestep     = LATEST                                          initial_from_file_var          = INVALID                                         element_order                  = AUTO                                            order                          = AUTO                                            side_order                     = AUTO                                            type                           = GAUSS                                         []                                                                                                                                                                [BCs]                                                                                                                                                               [./left]                                                                           boundary                     = left                                              control_tags                 = INVALID                                           enable                       = 1                                                 implicit                     = 1                                                 inactive                     =                                                   isObjectAction               = 1                                                 type                         = DirichletBC                                       use_displaced_mesh           = 0                                                 variable                     = u                                                 diag_save_in                 = INVALID                                           save_in                      = INVALID                                           seed                         = 0                                                 value                        = 1                                               [../]                                                                                                                                                             [./middle]                                                                         boundary                     = master0_interface                                 control_tags                 = INVALID                                           enable                       = 1                                                 implicit                     = 1                                                 inactive                     =                                                   isObjectAction               = 1                                                 type                         = MatchedValueBC                                    use_displaced_mesh           = 0                                                 variable                     = v                                                 diag_save_in                 = INVALID                                           save_in                      = INVALID                                           seed                         = 0                                                 v                            = u                                               [../]                                                                                                                                                             [./right]                                                                          boundary                     = right                                             control_tags                 = INVALID                                           enable                       = 1                                                 implicit                     = 1                                                 inactive                     =                                                   isObjectAction               = 1                                                 type                         = DirichletBC                                       use_displaced_mesh           = 0                                                 variable                     = v                                                 diag_save_in                 = INVALID                                           save_in                      = INVALID                                           seed                         = 0                                                 value                        = 0                                               [../]                                                                          []                                                                                                                                                                [Debug]                                                                            inactive                       =                                                 show_actions                   = 0                                               show_material_props            = 0                                               show_parser                    = 0                                               show_top_residuals             = 0                                               show_var_residual_norms        = 1                                               show_var_residual              = INVALID                                       []                                                                                                                                                                [Executioner]                                                                      inactive                       =                                                 isObjectAction                 = 1                                               type                           = Steady                                          compute_initial_residual_before_preset_bcs = 0                                   control_tags                   =                                                 enable                         = 1                                               l_abs_step_tol                 = -1                                              l_max_its                      = 10000                                           l_tol                          = 1e-05                                           line_search                    = default                                         mffd_type                      = wp                                              nl_abs_step_tol                = 1e-50                                           nl_abs_tol                     = 1e-50                                           nl_max_funcs                   = 10000                                           nl_max_its                     = 50                                              nl_rel_step_tol                = 1e-50                                           nl_rel_tol                     = 1e-08                                           no_fe_reinit                   = 0                                               petsc_options                  = INVALID                                         petsc_options_iname            = INVALID                                         petsc_options_value            = INVALID                                         restart_file_base              =                                                 solve_type                     = NEWTON                                          splitting                      = INVALID                                       []                                                                                                                                                                [Executioner]                                                                      _fe_problem                    = 0x7fcd19817400                                  _fe_problem_base               = 0x7fcd19817400                                []                                                                                                                                                                [InterfaceKernels]                                                                                                                                                  [./interface]                                                                      inactive                     =                                                   isObjectAction               = 1                                                 type                         = InterfaceDiffusion                                D                            = 4                                                 D_neighbor                   = 2                                                 _moose_base                  = InterfaceKernel                                   boundary                     = master0_interface                                 control_tags                 = InterfaceKernels                                  diag_save_in                 = INVALID                                           diag_save_in_var_side        = INVALID                                           enable                       = 1                                                 implicit                     = 1                                                 neighbor_var                 = v                                                 save_in                      = INVALID                                           save_in_var_side             = INVALID                                           use_displaced_mesh           = 0                                                 variable                     = u                                               [../]                                                                          []                                                                                                                                                                [Kernels]                                                                                                                                                           [./body_u]                                                                         inactive                     =                                                   isObjectAction               = 1                                                 type                         = BodyForce                                         block                        = 0                                                 control_tags                 = Kernels                                           diag_save_in                 = INVALID                                           eigen_kernel                 = 0                                                 enable                       = 1                                                 function                     = x                                                 implicit                     = 1                                                 postprocessor                = 1                                                 save_in                      = INVALID                                           seed                         = 0                                                 use_displaced_mesh           = 0                                                 value                        = 1                                                 variable                     = u                                               [../]                                                                                                                                                             [./body_v]                                                                         inactive                     =                                                   isObjectAction               = 1                                                 type                         = BodyForce                                         block                        = 1                                                 control_tags                 = Kernels                                           diag_save_in                 = INVALID                                           eigen_kernel                 = 0                                                 enable                       = 1                                                 function                     = x                                                 implicit                     = 1                                                 postprocessor                = 1                                                 save_in                      = INVALID                                           seed                         = 0                                                 use_displaced_mesh           = 0                                                 value                        = 1                                                 variable                     = v                                               [../]                                                                                                                                                             [./diff_u]                                                                         inactive                     =                                                   isObjectAction               = 1                                                 type                         = CoeffParamDiffusion                               D                            = 4                                                 block                        = 0                                                 control_tags                 = Kernels                                           diag_save_in                 = INVALID                                           eigen_kernel                 = 0                                                 enable                       = 1                                                 implicit                     = 1                                                 save_in                      = INVALID                                           seed                         = 0                                                 use_displaced_mesh           = 0                                                 variable                     = u                                               [../]                                                                                                                                                             [./diff_v]                                                                         inactive                     =                                                   isObjectAction               = 1                                                 type                         = CoeffParamDiffusion                               D                            = 2                                                 block                        = 1                                                 control_tags                 = Kernels                                           diag_save_in                 = INVALID                                           eigen_kernel                 = 0                                                 enable                       = 1                                                 implicit                     = 1                                                 save_in                      = INVALID                                           seed                         = 0                                                 use_displaced_mesh           = 0                                                 variable                     = v                                               [../]                                                                          []                                                                                                                                                                [Mesh]                                                                             inactive                       =                                                 displacements                  = INVALID                                         block_id                       = INVALID                                         block_name                     = INVALID                                         boundary_id                    = INVALID                                         boundary_name                  = INVALID                                         construct_side_list_from_node_list = 0                                           ghosted_boundaries             = INVALID                                         ghosted_boundaries_inflation   = INVALID                                         isObjectAction                 = 1                                               second_order                   = 0                                               skip_partitioning              = 0                                               type                           = GeneratedMesh                                   uniform_refine                 = 0                                               allow_renumbering              = 1                                               bias_x                         = 1                                               bias_y                         = 1                                               bias_z                         = 1                                               centroid_partitioner_direction = INVALID                                         construct_node_list_from_side_list = 1                                           control_tags                   =                                                 dim                            = 1                                               distribution                   = DEFAULT                                         elem_type                      = EDGE3                                           enable                         = 1                                               gauss_lobatto_grid             = 0                                               ghost_point_neighbors          = 0                                               nemesis                        = 0                                               num_ghosted_layers             = 1                                               nx                             = 10                                              ny                             = 1                                               nz                             = 1                                               parallel_type                  = DEFAULT                                         partitioner                    = default                                         patch_size                     = 40                                              patch_update_strategy          = never                                           xmax                           = 2                                               xmin                           = 0                                               ymax                           = 1                                               ymin                           = 0                                               zmax                           = 1                                               zmin                           = 0                                             []                                                                                                                                                                [Mesh]                                                                           []                                                                                                                                                                [MeshModifiers]                                                                                                                                                     [./interface]                                                                      inactive                     =                                                   isObjectAction               = 1                                                 type                         = SideSetsBetweenSubdomains                         _mesh                        = 0x7fcd19816c00                                    control_tags                 = MeshModifiers                                     depends_on                   = subdomain1                                        enable                       = 1                                                 force_prepare                = 0                                                 master_block                 = 0                                                 new_boundary                 = master0_interface                                 paired_block                 = 1                                               [../]                                                                                                                                                             [./interface_again]                                                                inactive                     =                                                   isObjectAction               = 1                                                 type                         = SideSetsBetweenSubdomains                         _mesh                        = 0x7fcd19816c00                                    control_tags                 = MeshModifiers                                     depends_on                   = subdomain1                                        enable                       = 1                                                 force_prepare                = 0                                                 master_block                 = 1                                                 new_boundary                 = master1_interface                                 paired_block                 = 0                                               [../]                                                                                                                                                             [./subdomain1]                                                                     inactive                     =                                                   isObjectAction               = 1                                                 type                         = SubdomainBoundingBox                              _mesh                        = 0x7fcd19816c00                                    block_id                     = 1                                                 block_name                   = INVALID                                           bottom_left                  = '(x,y,z)=(       1,        0,        0)'          control_tags                 = MeshModifiers                                     depends_on                   = INVALID                                           enable                       = 1                                                 force_prepare                = 0                                                 location                     = INSIDE                                            top_right                    = '(x,y,z)=(       2,        1,        0)'        [../]                                                                          []                                                                                                                                                                [Outputs]                                                                          append_date                    = 0                                               append_date_format             = INVALID                                         checkpoint                     = 0                                               color                          = 1                                               console                        = 1                                               controls                       = 0                                               csv                            = 0                                               dofmap                         = 0                                               execute_on                     = 'initial timestep_end'                          exodus                         = 1                                               file_base                      = INVALID                                         gmv                            = 0                                               gnuplot                        = 0                                               hide                           = INVALID                                         inactive                       =                                                 interval                       = 1                                               nemesis                        = 0                                               output_if_base_contains        = INVALID                                         print_linear_residuals         = 1                                               print_mesh_changed_info        = 0                                               print_perf_log                 = 0                                               show                           = INVALID                                         solution_history               = 0                                               sync_times                     =                                                 tecplot                        = 0                                               vtk                            = 0                                               xda                            = 0                                               xdr                            = 0                                             []                                                                                                                                                                [Preconditioning]                                                                                                                                                   [./smp]                                                                            inactive                     =                                                   isObjectAction               = 1                                                 type                         = SMP                                               control_tags                 = Preconditioning                                   coupled_groups               = INVALID                                           enable                       = 1                                                 full                         = 1                                                 ksp_norm                     = unpreconditioned                                  line_search                  = default                                           mffd_type                    = wp                                                off_diag_column              = INVALID                                           off_diag_row                 = INVALID                                           pc_side                      = default                                           petsc_options                = INVALID                                           petsc_options_iname          = INVALID                                           petsc_options_value          = INVALID                                           solve_type                   = INVALID                                         [../]                                                                          []                                                                                                                                                                [Variables]                                                                                                                                                         [./u]                                                                              block                        = 0                                                 eigen                        = 0                                                 family                       = LAGRANGE                                          inactive                     =                                                   initial_condition            = INVALID                                           order                        = FIRST                                             outputs                      = INVALID                                           scaling                      = 1                                                 initial_from_file_timestep   = LATEST                                            initial_from_file_var        = INVALID                                         [../]                                                                                                                                                             [./v]                                                                              block                        = 1                                                 eigen                        = 0                                                 family                       = LAGRANGE                                          inactive                     =                                                   initial_condition            = INVALID                                           order                        = SECOND                                            outputs                      = INVALID                                           scaling                      = 1                                                 initial_from_file_timestep   = LATEST                                            initial_from_file_var        = INVALID                                         [../]                                                                          []                                                                                                                                                                                                                                                                                                                                                                                                                                       ?�      ?�     �?�Jݣ���?�n��fN?�X�f�E?��N���?����\?�4Vx�P?쇟�5�q?�W��%�?�.���?��"��a�                                                                                                                                                        ?�.���        ?牫��J?�r� Ĝ�?� �g��?�o�����?ۢ?B�}�?��Sʆ�?��4Vy�?Ւ��,`a        ?�']��iL