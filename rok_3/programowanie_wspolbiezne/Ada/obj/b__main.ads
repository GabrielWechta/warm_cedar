pragma Warnings (Off);
pragma Ada_95;
with System;
with System.Parameters;
with System.Secondary_Stack;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: Community 2020 (20200429-93)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#3467f719#;
   pragma Export (C, u00001, "mainB");
   u00002 : constant Version_32 := 16#67c8d842#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#23d4d899#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#4fc9bc76#;
   pragma Export (C, u00005, "ada__command_lineB");
   u00006 : constant Version_32 := 16#3cdef8c9#;
   pragma Export (C, u00006, "ada__command_lineS");
   u00007 : constant Version_32 := 16#4635ec04#;
   pragma Export (C, u00007, "systemS");
   u00008 : constant Version_32 := 16#2d437d19#;
   pragma Export (C, u00008, "system__secondary_stackB");
   u00009 : constant Version_32 := 16#b79edb80#;
   pragma Export (C, u00009, "system__secondary_stackS");
   u00010 : constant Version_32 := 16#f435a12e#;
   pragma Export (C, u00010, "ada__exceptionsB");
   u00011 : constant Version_32 := 16#bb2e31f9#;
   pragma Export (C, u00011, "ada__exceptionsS");
   u00012 : constant Version_32 := 16#35e1815f#;
   pragma Export (C, u00012, "ada__exceptions__last_chance_handlerB");
   u00013 : constant Version_32 := 16#cfec26ee#;
   pragma Export (C, u00013, "ada__exceptions__last_chance_handlerS");
   u00014 : constant Version_32 := 16#ae860117#;
   pragma Export (C, u00014, "system__soft_linksB");
   u00015 : constant Version_32 := 16#39005bef#;
   pragma Export (C, u00015, "system__soft_linksS");
   u00016 : constant Version_32 := 16#ce3e0e21#;
   pragma Export (C, u00016, "system__soft_links__initializeB");
   u00017 : constant Version_32 := 16#5697fc2b#;
   pragma Export (C, u00017, "system__soft_links__initializeS");
   u00018 : constant Version_32 := 16#896564a3#;
   pragma Export (C, u00018, "system__parametersB");
   u00019 : constant Version_32 := 16#016728cf#;
   pragma Export (C, u00019, "system__parametersS");
   u00020 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00020, "system__stack_checkingB");
   u00021 : constant Version_32 := 16#c88a87ec#;
   pragma Export (C, u00021, "system__stack_checkingS");
   u00022 : constant Version_32 := 16#ced09590#;
   pragma Export (C, u00022, "system__storage_elementsB");
   u00023 : constant Version_32 := 16#6bf6a600#;
   pragma Export (C, u00023, "system__storage_elementsS");
   u00024 : constant Version_32 := 16#34742901#;
   pragma Export (C, u00024, "system__exception_tableB");
   u00025 : constant Version_32 := 16#795caff4#;
   pragma Export (C, u00025, "system__exception_tableS");
   u00026 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00026, "system__exceptionsB");
   u00027 : constant Version_32 := 16#2e5681f2#;
   pragma Export (C, u00027, "system__exceptionsS");
   u00028 : constant Version_32 := 16#69416224#;
   pragma Export (C, u00028, "system__exceptions__machineB");
   u00029 : constant Version_32 := 16#5c74e542#;
   pragma Export (C, u00029, "system__exceptions__machineS");
   u00030 : constant Version_32 := 16#aa0563fc#;
   pragma Export (C, u00030, "system__exceptions_debugB");
   u00031 : constant Version_32 := 16#5a783f72#;
   pragma Export (C, u00031, "system__exceptions_debugS");
   u00032 : constant Version_32 := 16#6c2f8802#;
   pragma Export (C, u00032, "system__img_intB");
   u00033 : constant Version_32 := 16#44ee0cc6#;
   pragma Export (C, u00033, "system__img_intS");
   u00034 : constant Version_32 := 16#39df8c17#;
   pragma Export (C, u00034, "system__tracebackB");
   u00035 : constant Version_32 := 16#181732c0#;
   pragma Export (C, u00035, "system__tracebackS");
   u00036 : constant Version_32 := 16#9ed49525#;
   pragma Export (C, u00036, "system__traceback_entriesB");
   u00037 : constant Version_32 := 16#466e1a74#;
   pragma Export (C, u00037, "system__traceback_entriesS");
   u00038 : constant Version_32 := 16#e162df04#;
   pragma Export (C, u00038, "system__traceback__symbolicB");
   u00039 : constant Version_32 := 16#46491211#;
   pragma Export (C, u00039, "system__traceback__symbolicS");
   u00040 : constant Version_32 := 16#179d7d28#;
   pragma Export (C, u00040, "ada__containersS");
   u00041 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00041, "ada__exceptions__tracebackB");
   u00042 : constant Version_32 := 16#ae2d2db5#;
   pragma Export (C, u00042, "ada__exceptions__tracebackS");
   u00043 : constant Version_32 := 16#5ab55268#;
   pragma Export (C, u00043, "interfacesS");
   u00044 : constant Version_32 := 16#e49bce3e#;
   pragma Export (C, u00044, "interfaces__cB");
   u00045 : constant Version_32 := 16#dbc36ce0#;
   pragma Export (C, u00045, "interfaces__cS");
   u00046 : constant Version_32 := 16#e865e681#;
   pragma Export (C, u00046, "system__bounded_stringsB");
   u00047 : constant Version_32 := 16#31c8cd1d#;
   pragma Export (C, u00047, "system__bounded_stringsS");
   u00048 : constant Version_32 := 16#0fdcf3be#;
   pragma Export (C, u00048, "system__crtlS");
   u00049 : constant Version_32 := 16#108b4f79#;
   pragma Export (C, u00049, "system__dwarf_linesB");
   u00050 : constant Version_32 := 16#345b739f#;
   pragma Export (C, u00050, "system__dwarf_linesS");
   u00051 : constant Version_32 := 16#5b4659fa#;
   pragma Export (C, u00051, "ada__charactersS");
   u00052 : constant Version_32 := 16#8f637df8#;
   pragma Export (C, u00052, "ada__characters__handlingB");
   u00053 : constant Version_32 := 16#3b3f6154#;
   pragma Export (C, u00053, "ada__characters__handlingS");
   u00054 : constant Version_32 := 16#4b7bb96a#;
   pragma Export (C, u00054, "ada__characters__latin_1S");
   u00055 : constant Version_32 := 16#e6d4fa36#;
   pragma Export (C, u00055, "ada__stringsS");
   u00056 : constant Version_32 := 16#96df1a3f#;
   pragma Export (C, u00056, "ada__strings__mapsB");
   u00057 : constant Version_32 := 16#1e526bec#;
   pragma Export (C, u00057, "ada__strings__mapsS");
   u00058 : constant Version_32 := 16#32cfc5a0#;
   pragma Export (C, u00058, "system__bit_opsB");
   u00059 : constant Version_32 := 16#0765e3a3#;
   pragma Export (C, u00059, "system__bit_opsS");
   u00060 : constant Version_32 := 16#18fa9e16#;
   pragma Export (C, u00060, "system__unsigned_typesS");
   u00061 : constant Version_32 := 16#92f05f13#;
   pragma Export (C, u00061, "ada__strings__maps__constantsS");
   u00062 : constant Version_32 := 16#a0d3d22b#;
   pragma Export (C, u00062, "system__address_imageB");
   u00063 : constant Version_32 := 16#e7d9713e#;
   pragma Export (C, u00063, "system__address_imageS");
   u00064 : constant Version_32 := 16#8631cc2e#;
   pragma Export (C, u00064, "system__img_unsB");
   u00065 : constant Version_32 := 16#870ea2e1#;
   pragma Export (C, u00065, "system__img_unsS");
   u00066 : constant Version_32 := 16#20ec7aa3#;
   pragma Export (C, u00066, "system__ioB");
   u00067 : constant Version_32 := 16#d8771b4b#;
   pragma Export (C, u00067, "system__ioS");
   u00068 : constant Version_32 := 16#f790d1ef#;
   pragma Export (C, u00068, "system__mmapB");
   u00069 : constant Version_32 := 16#ee41b8bb#;
   pragma Export (C, u00069, "system__mmapS");
   u00070 : constant Version_32 := 16#92d882c5#;
   pragma Export (C, u00070, "ada__io_exceptionsS");
   u00071 : constant Version_32 := 16#91eaca2e#;
   pragma Export (C, u00071, "system__mmap__os_interfaceB");
   u00072 : constant Version_32 := 16#1fc2f713#;
   pragma Export (C, u00072, "system__mmap__os_interfaceS");
   u00073 : constant Version_32 := 16#8c787ae2#;
   pragma Export (C, u00073, "system__mmap__unixS");
   u00074 : constant Version_32 := 16#11eb9166#;
   pragma Export (C, u00074, "system__os_libB");
   u00075 : constant Version_32 := 16#d872da39#;
   pragma Export (C, u00075, "system__os_libS");
   u00076 : constant Version_32 := 16#ec4d5631#;
   pragma Export (C, u00076, "system__case_utilB");
   u00077 : constant Version_32 := 16#79e05a50#;
   pragma Export (C, u00077, "system__case_utilS");
   u00078 : constant Version_32 := 16#2a8e89ad#;
   pragma Export (C, u00078, "system__stringsB");
   u00079 : constant Version_32 := 16#2623c091#;
   pragma Export (C, u00079, "system__stringsS");
   u00080 : constant Version_32 := 16#c83ab8ef#;
   pragma Export (C, u00080, "system__object_readerB");
   u00081 : constant Version_32 := 16#82413105#;
   pragma Export (C, u00081, "system__object_readerS");
   u00082 : constant Version_32 := 16#914b0305#;
   pragma Export (C, u00082, "system__val_lliB");
   u00083 : constant Version_32 := 16#2a5b7ef4#;
   pragma Export (C, u00083, "system__val_lliS");
   u00084 : constant Version_32 := 16#d2ae2792#;
   pragma Export (C, u00084, "system__val_lluB");
   u00085 : constant Version_32 := 16#753413f4#;
   pragma Export (C, u00085, "system__val_lluS");
   u00086 : constant Version_32 := 16#269742a9#;
   pragma Export (C, u00086, "system__val_utilB");
   u00087 : constant Version_32 := 16#ea955afa#;
   pragma Export (C, u00087, "system__val_utilS");
   u00088 : constant Version_32 := 16#b578159b#;
   pragma Export (C, u00088, "system__exception_tracesB");
   u00089 : constant Version_32 := 16#62eacc9e#;
   pragma Export (C, u00089, "system__exception_tracesS");
   u00090 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00090, "system__wch_conB");
   u00091 : constant Version_32 := 16#5d48ced6#;
   pragma Export (C, u00091, "system__wch_conS");
   u00092 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00092, "system__wch_stwB");
   u00093 : constant Version_32 := 16#7059e2d7#;
   pragma Export (C, u00093, "system__wch_stwS");
   u00094 : constant Version_32 := 16#a831679c#;
   pragma Export (C, u00094, "system__wch_cnvB");
   u00095 : constant Version_32 := 16#52ff7425#;
   pragma Export (C, u00095, "system__wch_cnvS");
   u00096 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00096, "system__wch_jisB");
   u00097 : constant Version_32 := 16#d28f6d04#;
   pragma Export (C, u00097, "system__wch_jisS");
   u00098 : constant Version_32 := 16#f4e097a7#;
   pragma Export (C, u00098, "ada__text_ioB");
   u00099 : constant Version_32 := 16#777d5329#;
   pragma Export (C, u00099, "ada__text_ioS");
   u00100 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00100, "ada__streamsB");
   u00101 : constant Version_32 := 16#67e31212#;
   pragma Export (C, u00101, "ada__streamsS");
   u00102 : constant Version_32 := 16#f9576a72#;
   pragma Export (C, u00102, "ada__tagsB");
   u00103 : constant Version_32 := 16#b6661f55#;
   pragma Export (C, u00103, "ada__tagsS");
   u00104 : constant Version_32 := 16#796f31f1#;
   pragma Export (C, u00104, "system__htableB");
   u00105 : constant Version_32 := 16#c2f75fee#;
   pragma Export (C, u00105, "system__htableS");
   u00106 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00106, "system__string_hashB");
   u00107 : constant Version_32 := 16#60a93490#;
   pragma Export (C, u00107, "system__string_hashS");
   u00108 : constant Version_32 := 16#73d2d764#;
   pragma Export (C, u00108, "interfaces__c_streamsB");
   u00109 : constant Version_32 := 16#b1330297#;
   pragma Export (C, u00109, "interfaces__c_streamsS");
   u00110 : constant Version_32 := 16#ec9c64c3#;
   pragma Export (C, u00110, "system__file_ioB");
   u00111 : constant Version_32 := 16#e1440d61#;
   pragma Export (C, u00111, "system__file_ioS");
   u00112 : constant Version_32 := 16#86c56e5a#;
   pragma Export (C, u00112, "ada__finalizationS");
   u00113 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00113, "system__finalization_rootB");
   u00114 : constant Version_32 := 16#09c79f94#;
   pragma Export (C, u00114, "system__finalization_rootS");
   u00115 : constant Version_32 := 16#bbaa76ac#;
   pragma Export (C, u00115, "system__file_control_blockS");
   u00116 : constant Version_32 := 16#f0ba7a0e#;
   pragma Export (C, u00116, "graphB");
   u00117 : constant Version_32 := 16#cba40acf#;
   pragma Export (C, u00117, "graphS");
   u00118 : constant Version_32 := 16#ffaa9e94#;
   pragma Export (C, u00118, "ada__calendar__delaysB");
   u00119 : constant Version_32 := 16#d86d2f1d#;
   pragma Export (C, u00119, "ada__calendar__delaysS");
   u00120 : constant Version_32 := 16#c47dab26#;
   pragma Export (C, u00120, "ada__calendarB");
   u00121 : constant Version_32 := 16#31350a81#;
   pragma Export (C, u00121, "ada__calendarS");
   u00122 : constant Version_32 := 16#51f2d040#;
   pragma Export (C, u00122, "system__os_primitivesB");
   u00123 : constant Version_32 := 16#41c889f2#;
   pragma Export (C, u00123, "system__os_primitivesS");
   u00124 : constant Version_32 := 16#cd2959fb#;
   pragma Export (C, u00124, "ada__numericsS");
   u00125 : constant Version_32 := 16#d976e2b4#;
   pragma Export (C, u00125, "ada__numerics__float_randomB");
   u00126 : constant Version_32 := 16#62aa8dd2#;
   pragma Export (C, u00126, "ada__numerics__float_randomS");
   u00127 : constant Version_32 := 16#93bf75e3#;
   pragma Export (C, u00127, "system__random_numbersB");
   u00128 : constant Version_32 := 16#852d5c9e#;
   pragma Export (C, u00128, "system__random_numbersS");
   u00129 : constant Version_32 := 16#15692802#;
   pragma Export (C, u00129, "system__random_seedB");
   u00130 : constant Version_32 := 16#1d25c55f#;
   pragma Export (C, u00130, "system__random_seedS");
   u00131 : constant Version_32 := 16#5276dcb7#;
   pragma Export (C, u00131, "system__val_unsB");
   u00132 : constant Version_32 := 16#2dfce3af#;
   pragma Export (C, u00132, "system__val_unsS");
   u00133 : constant Version_32 := 16#72faaa41#;
   pragma Export (C, u00133, "ada__real_timeB");
   u00134 : constant Version_32 := 16#1ad7dfc0#;
   pragma Export (C, u00134, "ada__real_timeS");
   u00135 : constant Version_32 := 16#2ad479f4#;
   pragma Export (C, u00135, "system__taskingB");
   u00136 : constant Version_32 := 16#61c59a23#;
   pragma Export (C, u00136, "system__taskingS");
   u00137 : constant Version_32 := 16#d56481e0#;
   pragma Export (C, u00137, "system__task_primitivesS");
   u00138 : constant Version_32 := 16#868709f6#;
   pragma Export (C, u00138, "system__os_interfaceB");
   u00139 : constant Version_32 := 16#fb6ffe9f#;
   pragma Export (C, u00139, "system__os_interfaceS");
   u00140 : constant Version_32 := 16#6d1a9ca9#;
   pragma Export (C, u00140, "system__linuxS");
   u00141 : constant Version_32 := 16#7fa4fe77#;
   pragma Export (C, u00141, "system__os_constantsS");
   u00142 : constant Version_32 := 16#0b0a903e#;
   pragma Export (C, u00142, "system__task_primitives__operationsB");
   u00143 : constant Version_32 := 16#3217be90#;
   pragma Export (C, u00143, "system__task_primitives__operationsS");
   u00144 : constant Version_32 := 16#71c5de81#;
   pragma Export (C, u00144, "system__interrupt_managementB");
   u00145 : constant Version_32 := 16#a0f0a528#;
   pragma Export (C, u00145, "system__interrupt_managementS");
   u00146 : constant Version_32 := 16#64507e17#;
   pragma Export (C, u00146, "system__multiprocessorsB");
   u00147 : constant Version_32 := 16#7e997377#;
   pragma Export (C, u00147, "system__multiprocessorsS");
   u00148 : constant Version_32 := 16#375a3ef7#;
   pragma Export (C, u00148, "system__task_infoB");
   u00149 : constant Version_32 := 16#0a51c33f#;
   pragma Export (C, u00149, "system__task_infoS");
   u00150 : constant Version_32 := 16#83ab03df#;
   pragma Export (C, u00150, "system__tasking__debugB");
   u00151 : constant Version_32 := 16#b8f2c89f#;
   pragma Export (C, u00151, "system__tasking__debugS");
   u00152 : constant Version_32 := 16#fd83e873#;
   pragma Export (C, u00152, "system__concat_2B");
   u00153 : constant Version_32 := 16#44953bd4#;
   pragma Export (C, u00153, "system__concat_2S");
   u00154 : constant Version_32 := 16#2b70b149#;
   pragma Export (C, u00154, "system__concat_3B");
   u00155 : constant Version_32 := 16#4d45b0a1#;
   pragma Export (C, u00155, "system__concat_3S");
   u00156 : constant Version_32 := 16#b31a5821#;
   pragma Export (C, u00156, "system__img_enum_newB");
   u00157 : constant Version_32 := 16#2779eac4#;
   pragma Export (C, u00157, "system__img_enum_newS");
   u00158 : constant Version_32 := 16#9dca6636#;
   pragma Export (C, u00158, "system__img_lliB");
   u00159 : constant Version_32 := 16#577ab9d5#;
   pragma Export (C, u00159, "system__img_lliS");
   u00160 : constant Version_32 := 16#617d5887#;
   pragma Export (C, u00160, "system__stack_usageB");
   u00161 : constant Version_32 := 16#3a3ac346#;
   pragma Export (C, u00161, "system__stack_usageS");
   u00162 : constant Version_32 := 16#932a4690#;
   pragma Export (C, u00162, "system__concat_4B");
   u00163 : constant Version_32 := 16#3851c724#;
   pragma Export (C, u00163, "system__concat_4S");
   u00164 : constant Version_32 := 16#5525e9d4#;
   pragma Export (C, u00164, "system__tasking__rendezvousB");
   u00165 : constant Version_32 := 16#e93c6c5f#;
   pragma Export (C, u00165, "system__tasking__rendezvousS");
   u00166 : constant Version_32 := 16#100eaf58#;
   pragma Export (C, u00166, "system__restrictionsB");
   u00167 : constant Version_32 := 16#af5cb204#;
   pragma Export (C, u00167, "system__restrictionsS");
   u00168 : constant Version_32 := 16#6b13b0d6#;
   pragma Export (C, u00168, "system__tasking__entry_callsB");
   u00169 : constant Version_32 := 16#526fb901#;
   pragma Export (C, u00169, "system__tasking__entry_callsS");
   u00170 : constant Version_32 := 16#0e49b045#;
   pragma Export (C, u00170, "system__tasking__initializationB");
   u00171 : constant Version_32 := 16#cd0eb8a9#;
   pragma Export (C, u00171, "system__tasking__initializationS");
   u00172 : constant Version_32 := 16#069cc619#;
   pragma Export (C, u00172, "system__soft_links__taskingB");
   u00173 : constant Version_32 := 16#e939497e#;
   pragma Export (C, u00173, "system__soft_links__taskingS");
   u00174 : constant Version_32 := 16#3880736e#;
   pragma Export (C, u00174, "ada__exceptions__is_null_occurrenceB");
   u00175 : constant Version_32 := 16#6fde25af#;
   pragma Export (C, u00175, "ada__exceptions__is_null_occurrenceS");
   u00176 : constant Version_32 := 16#f05829b0#;
   pragma Export (C, u00176, "system__tasking__task_attributesB");
   u00177 : constant Version_32 := 16#7dbadc03#;
   pragma Export (C, u00177, "system__tasking__task_attributesS");
   u00178 : constant Version_32 := 16#1d360171#;
   pragma Export (C, u00178, "system__tasking__protected_objectsB");
   u00179 : constant Version_32 := 16#242da0e0#;
   pragma Export (C, u00179, "system__tasking__protected_objectsS");
   u00180 : constant Version_32 := 16#365b53e6#;
   pragma Export (C, u00180, "system__tasking__protected_objects__entriesB");
   u00181 : constant Version_32 := 16#7daf93e7#;
   pragma Export (C, u00181, "system__tasking__protected_objects__entriesS");
   u00182 : constant Version_32 := 16#8a95b8fa#;
   pragma Export (C, u00182, "system__tasking__protected_objects__operationsB");
   u00183 : constant Version_32 := 16#343fde45#;
   pragma Export (C, u00183, "system__tasking__protected_objects__operationsS");
   u00184 : constant Version_32 := 16#fcf219ee#;
   pragma Export (C, u00184, "system__tasking__queuingB");
   u00185 : constant Version_32 := 16#73e13001#;
   pragma Export (C, u00185, "system__tasking__queuingS");
   u00186 : constant Version_32 := 16#3a5c1973#;
   pragma Export (C, u00186, "system__tasking__utilitiesB");
   u00187 : constant Version_32 := 16#3e4ab368#;
   pragma Export (C, u00187, "system__tasking__utilitiesS");
   u00188 : constant Version_32 := 16#c2fee355#;
   pragma Export (C, u00188, "system__tasking__stagesB");
   u00189 : constant Version_32 := 16#2a734fd3#;
   pragma Export (C, u00189, "system__tasking__stagesS");
   u00190 : constant Version_32 := 16#65de8d35#;
   pragma Export (C, u00190, "system__val_intB");
   u00191 : constant Version_32 := 16#f3ca8567#;
   pragma Export (C, u00191, "system__val_intS");
   u00192 : constant Version_32 := 16#eca5ecae#;
   pragma Export (C, u00192, "system__memoryB");
   u00193 : constant Version_32 := 16#1f488a30#;
   pragma Export (C, u00193, "system__memoryS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  interfaces%s
   --  system%s
   --  system.img_enum_new%s
   --  system.img_enum_new%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.img_lli%s
   --  system.img_lli%b
   --  system.io%s
   --  system.io%b
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.restrictions%s
   --  system.restrictions%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.stack_usage%s
   --  system.stack_usage%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%s
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.unsigned_types%s
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.concat_4%s
   --  system.concat_4%b
   --  system.traceback%s
   --  system.traceback%b
   --  ada.characters.handling%s
   --  system.case_util%s
   --  system.os_lib%s
   --  system.secondary_stack%s
   --  system.standard_library%s
   --  ada.exceptions%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.soft_links%s
   --  system.val_lli%s
   --  system.val_llu%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  ada.exceptions.traceback%b
   --  system.address_image%s
   --  system.address_image%b
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.bounded_strings%s
   --  system.bounded_strings%b
   --  system.case_util%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  ada.strings.maps%s
   --  ada.strings.maps%b
   --  ada.strings.maps.constants%s
   --  interfaces.c%s
   --  interfaces.c%b
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  ada.characters.handling%b
   --  system.exception_traces%s
   --  system.exception_traces%b
   --  system.memory%s
   --  system.memory%b
   --  system.mmap%s
   --  system.mmap.os_interface%s
   --  system.mmap%b
   --  system.mmap.unix%s
   --  system.mmap.os_interface%b
   --  system.object_reader%s
   --  system.object_reader%b
   --  system.dwarf_lines%s
   --  system.dwarf_lines%b
   --  system.os_lib%b
   --  system.secondary_stack%b
   --  system.soft_links.initialize%s
   --  system.soft_links.initialize%b
   --  system.soft_links%b
   --  system.standard_library%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  system.val_lli%b
   --  system.val_llu%b
   --  ada.command_line%s
   --  ada.command_line%b
   --  ada.exceptions.is_null_occurrence%s
   --  ada.exceptions.is_null_occurrence%b
   --  ada.numerics%s
   --  ada.tags%s
   --  ada.tags%b
   --  ada.streams%s
   --  ada.streams%b
   --  system.file_control_block%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  system.file_io%s
   --  system.file_io%b
   --  system.linux%s
   --  system.multiprocessors%s
   --  system.multiprocessors%b
   --  system.os_constants%s
   --  system.os_interface%s
   --  system.os_interface%b
   --  system.task_info%s
   --  system.task_info%b
   --  system.task_primitives%s
   --  system.interrupt_management%s
   --  system.interrupt_management%b
   --  system.tasking%s
   --  system.task_primitives.operations%s
   --  system.tasking.debug%s
   --  system.tasking.debug%b
   --  system.task_primitives.operations%b
   --  system.tasking%b
   --  system.val_uns%s
   --  system.val_uns%b
   --  system.val_int%s
   --  system.val_int%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.calendar.delays%s
   --  ada.calendar.delays%b
   --  ada.real_time%s
   --  ada.real_time%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  system.random_seed%s
   --  system.random_seed%b
   --  system.random_numbers%s
   --  system.random_numbers%b
   --  ada.numerics.float_random%s
   --  ada.numerics.float_random%b
   --  system.soft_links.tasking%s
   --  system.soft_links.tasking%b
   --  system.tasking.initialization%s
   --  system.tasking.task_attributes%s
   --  system.tasking.task_attributes%b
   --  system.tasking.initialization%b
   --  system.tasking.protected_objects%s
   --  system.tasking.protected_objects%b
   --  system.tasking.protected_objects.entries%s
   --  system.tasking.protected_objects.entries%b
   --  system.tasking.queuing%s
   --  system.tasking.queuing%b
   --  system.tasking.utilities%s
   --  system.tasking.utilities%b
   --  system.tasking.entry_calls%s
   --  system.tasking.rendezvous%s
   --  system.tasking.protected_objects.operations%s
   --  system.tasking.protected_objects.operations%b
   --  system.tasking.entry_calls%b
   --  system.tasking.rendezvous%b
   --  system.tasking.stages%s
   --  system.tasking.stages%b
   --  graph%s
   --  graph%b
   --  main%b
   --  END ELABORATION ORDER

end ada_main;
