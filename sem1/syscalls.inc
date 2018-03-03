%ifndef ASM_LABS_SYSCALLS
%define ASM_LABS_SYSCALLS

;; vim: syntax=asm

; syscall codes {{{
%define sys_read_code                    0
%define sys_write_code                   1
%define sys_open_code                    2
%define sys_close_code                   3
%define sys_stat_code                    4
%define sys_fstat_code                   5
%define sys_lstat_code                   6
%define sys_poll_code                    7
%define sys_lseek_code                   8
%define sys_mmap_code                    9
%define sys_mprotect_code                10
%define sys_munmap_code                  11
%define sys_brk_code                     12
%define sys_rt_sigaction_code            13
%define sys_rt_sigprocmask_code          14
%define sys_rt_sigreturn_code            15
%define sys_ioctl_code                   16
%define sys_pread64_code                 17
%define sys_pwrite64_code                18
%define sys_readv_code                   19
%define sys_writev_code                  20
%define sys_access_code                  21
%define sys_pipe_code                    22
%define sys_select_code                  23
%define sys_sched_yield_code             24
%define sys_mremap_code                  25
%define sys_msync_code                   26
%define sys_mincore_code                 27
%define sys_madvise_code                 28
%define sys_shmget_code                  29
%define sys_shmat_code                   30
%define sys_shmctl_code                  31
%define sys_dup_code                     32
%define sys_dup2_code                    33
%define sys_pause_code                   34
%define sys_nanosleep_code               35
%define sys_getitimer_code               36
%define sys_alarm_code                   37
%define sys_setitimer_code               38
%define sys_getpid_code                  39
%define sys_sendfile_code                40
%define sys_socket_code                  41
%define sys_connect_code                 42
%define sys_accept_code                  43
%define sys_sendto_code                  44
%define sys_recvfrom_code                45
%define sys_sendmsg_code                 46
%define sys_recvmsg_code                 47
%define sys_shutdown_code                48
%define sys_bind_code                    49
%define sys_listen_code                  50
%define sys_getsockname_code             51
%define sys_getpeername_code             52
%define sys_socketpair_code              53
%define sys_setsockopt_code              54
%define sys_getsockopt_code              55
%define sys_clone_code                   56
%define sys_fork_code                    57
%define sys_vfork_code                   58
%define sys_execve_code                  59
%define sys_exit_code                    60
%define sys_wait4_code                   61
%define sys_kill_code                    62
%define sys_uname_code                   63
%define sys_semget_code                  64
%define sys_semop_code                   65
%define sys_semctl_code                  66
%define sys_shmdt_code                   67
%define sys_msgget_code                  68
%define sys_msgsnd_code                  69
%define sys_msgrcv_code                  70
%define sys_msgctl_code                  71
%define sys_fcntl_code                   72
%define sys_flock_code                   73
%define sys_fsync_code                   74
%define sys_fdatasync_code               75
%define sys_truncate_code                76
%define sys_ftruncate_code               77
%define sys_getdents_code                78
%define sys_getcwd_code                  79
%define sys_chdir_code                   80
%define sys_fchdir_code                  81
%define sys_rename_code                  82
%define sys_mkdir_code                   83
%define sys_rmdir_code                   84
%define sys_creat_code                   85
%define sys_link_code                    86
%define sys_unlink_code                  87
%define sys_symlink_code                 88
%define sys_readlink_code                89
%define sys_chmod_code                   90
%define sys_fchmod_code                  91
%define sys_chown_code                   92
%define sys_fchown_code                  93
%define sys_lchown_code                  94
%define sys_umask_code                   95
%define sys_gettimeofday_code            96
%define sys_getrlimit_code               97
%define sys_getrusage_code               98
%define sys_sysinfo_code                 99
%define sys_times_code                   100
%define sys_ptrace_code                  101
%define sys_getuid_code                  102
%define sys_syslog_code                  103
%define sys_getgid_code                  104
%define sys_setuid_code                  105
%define sys_setgid_code                  106
%define sys_geteuid_code                 107
%define sys_getegid_code                 108
%define sys_setpgid_code                 109
%define sys_getppid_code                 110
%define sys_getpgrp_code                 111
%define sys_setsid_code                  112
%define sys_setreuid_code                113
%define sys_setregid_code                114
%define sys_getgroups_code               115
%define sys_setgroups_code               116
%define sys_setresuid_code               117
%define sys_getresuid_code               118
%define sys_setresgid_code               119
%define sys_getresgid_code               120
%define sys_getpgid_code                 121
%define sys_setfsuid_code                122
%define sys_setfsgid_code                123
%define sys_getsid_code                  124
%define sys_capget_code                  125
%define sys_capset_code                  126
%define sys_rt_sigpending_code           127
%define sys_rt_sigtimedwait_code         128
%define sys_rt_sigqueueinfo_code         129
%define sys_rt_sigsuspend_code           130
%define sys_sigaltstack_code             131
%define sys_utime_code                   132
%define sys_mknod_code                   133
%define sys_uselib_code                  134
%define sys_personality_code             135
%define sys_ustat_code                   136
%define sys_statfs_code                  137
%define sys_fstatfs_code                 138
%define sys_sysfs_code                   139
%define sys_getpriority_code             140
%define sys_setpriority_code             141
%define sys_sched_setparam_code          142
%define sys_sched_getparam_code          143
%define sys_sched_setscheduler_code      144
%define sys_sched_getscheduler_code      145
%define sys_sched_get_priority_max_code  146
%define sys_sched_get_priority_min_code  147
%define sys_sched_rr_get_interval_code   148
%define sys_mlock_code                   149
%define sys_munlock_code                 150
%define sys_mlockall_code                151
%define sys_munlockall_code              152
%define sys_vhangup_code                 153
%define sys_modify_ldt_code              154
%define sys_pivot_root_code              155
%define sys__sysctl_code                 156
%define sys_prctl_code                   157
%define sys_arch_prctl_code              158
%define sys_adjtimex_code                159
%define sys_setrlimit_code               160
%define sys_chroot_code                  161
%define sys_sync_code                    162
%define sys_acct_code                    163
%define sys_settimeofday_code            164
%define sys_mount_code                   165
%define sys_umount2_code                 166
%define sys_swapon_code                  167
%define sys_swapoff_code                 168
%define sys_reboot_code                  169
%define sys_sethostname_code             170
%define sys_setdomainname_code           171
%define sys_iopl_code                    172
%define sys_ioperm_code                  173
%define sys_create_module_code           174
%define sys_init_module_code             175
%define sys_delete_module_code           176
%define sys_get_kernel_syms_code         177
%define sys_query_module_code            178
%define sys_quotactl_code                179
%define sys_nfsservctl_code              180
%define sys_getpmsg_code                 181
%define sys_putpmsg_code                 182
%define sys_afs_syscall_code             183
%define sys_tuxcall_code                 184
%define sys_security_code                185
%define sys_gettid_code                  186
%define sys_readahead_code               187
%define sys_setxattr_code                188
%define sys_lsetxattr_code               189
%define sys_fsetxattr_code               190
%define sys_getxattr_code                191
%define sys_lgetxattr_code               192
%define sys_fgetxattr_code               193
%define sys_listxattr_code               194
%define sys_llistxattr_code              195
%define sys_flistxattr_code              196
%define sys_removexattr_code             197
%define sys_lremovexattr_code            198
%define sys_fremovexattr_code            199
%define sys_tkill_code                   200
%define sys_time_code                    201
%define sys_futex_code                   202
%define sys_sched_setaffinity_code       203
%define sys_sched_getaffinity_code       204
%define sys_set_thread_area_code         205
%define sys_io_setup_code                206
%define sys_io_destroy_code              207
%define sys_io_getevents_code            208
%define sys_io_submit_code               209
%define sys_io_cancel_code               210
%define sys_get_thread_area_code         211
%define sys_lookup_dcookie_code          212
%define sys_epoll_create_code            213
%define sys_epoll_ctl_old_code           214
%define sys_epoll_wait_old_code          215
%define sys_remap_file_pages_code        216
%define sys_getdents64_code              217
%define sys_set_tid_address_code         218
%define sys_restart_syscall_code         219
%define sys_semtimedop_code              220
%define sys_fadvise64_code               221
%define sys_timer_create_code            222
%define sys_timer_settime_code           223
%define sys_timer_gettime_code           224
%define sys_timer_getoverrun_code        225
%define sys_timer_delete_code            226
%define sys_clock_settime_code           227
%define sys_clock_gettime_code           228
%define sys_clock_getres_code            229
%define sys_clock_nanosleep_code         230
%define sys_exit_group_code              231
%define sys_epoll_wait_code              232
%define sys_epoll_ctl_code               233
%define sys_tgkill_code                  234
%define sys_utimes_code                  235
%define sys_vserver_code                 236
%define sys_mbind_code                   237
%define sys_set_mempolicy_code           238
%define sys_get_mempolicy_code           239
%define sys_mq_open_code                 240
%define sys_mq_unlink_code               241
%define sys_mq_timedsend_code            242
%define sys_mq_timedreceive_code         243
%define sys_mq_notify_code               244
%define sys_mq_getsetattr_code           245
%define sys_kexec_load_code              246
%define sys_waitid_code                  247
%define sys_add_key_code                 248
%define sys_request_key_code             249
%define sys_keyctl_code                  250
%define sys_ioprio_set_code              251
%define sys_ioprio_get_code              252
%define sys_inotify_init_code            253
%define sys_inotify_add_watch_code       254
%define sys_inotify_rm_watch_code        255
%define sys_migrate_pages_code           256
%define sys_openat_code                  257
%define sys_mkdirat_code                 258
%define sys_mknodat_code                 259
%define sys_fchownat_code                260
%define sys_futimesat_code               261
%define sys_newfstatat_code              262
%define sys_unlinkat_code                263
%define sys_renameat_code                264
%define sys_linkat_code                  265
%define sys_symlinkat_code               266
%define sys_readlinkat_code              267
%define sys_fchmodat_code                268
%define sys_faccessat_code               269
%define sys_pselect6_code                270
%define sys_ppoll_code                   271
%define sys_unshare_code                 272
%define sys_set_robust_list_code         273
%define sys_get_robust_list_code         274
%define sys_splice_code                  275
%define sys_tee_code                     276
%define sys_sync_file_range_code         277
%define sys_vmsplice_code                278
%define sys_move_pages_code              279
%define sys_utimensat_code               280
%define sys_epoll_pwait_code             281
%define sys_signalfd_code                282
%define sys_timerfd_create_code          283
%define sys_eventfd_code                 284
%define sys_fallocate_code               285
%define sys_timerfd_settime_code         286
%define sys_timerfd_gettime_code         287
%define sys_accept4_code                 288
%define sys_signalfd4_code               289
%define sys_eventfd2_code                290
%define sys_epoll_create1_code           291
%define sys_dup3_code                    292
%define sys_pipe2_code                   293
%define sys_inotify_init1_code           294
%define sys_preadv_code                  295
%define sys_pwritev_code                 296
%define sys_rt_tgsigqueueinfo_code       297
%define sys_perf_event_open_code         298
%define sys_recvmmsg_code                299
%define sys_fanotify_init_code           300
%define sys_fanotify_mark_code           301
%define sys_prlimit64_code               302
%define sys_name_to_handle_at_code       303
%define sys_open_by_handle_at_code       304
%define sys_clock_adjtime_code           305
%define sys_syncfs_code                  306
%define sys_sendmmsg_code                307
%define sys_setns_code                   308
%define sys_getcpu_code                  309
%define sys_process_vm_readv_code        310
%define sys_process_vm_writev_code       311
%define sys_kcmp_code                    312
%define sys_finit_module_code            313
; }}}

; syscall macros {{{
%macro sys_read 1+
    sys_call sys_read_code , %1
%endmacro
%macro sys_write 1+
    sys_call sys_write_code , %1
%endmacro
%macro sys_open 1+
    sys_call sys_open_code , %1
%endmacro
%macro sys_close 1+
    sys_call sys_close_code , %1
%endmacro
%macro sys_stat 1+
    sys_call sys_stat_code , %1
%endmacro
%macro sys_fstat 1+
    sys_call sys_fstat_code , %1
%endmacro
%macro sys_lstat 1+
    sys_call sys_lstat_code , %1
%endmacro
%macro sys_poll 1+
    sys_call sys_poll_code , %1
%endmacro
%macro sys_lseek 1+
    sys_call sys_lseek_code , %1
%endmacro
%macro sys_mmap 1+
    sys_call sys_mmap_code , %1
%endmacro
%macro sys_mprotect 1+
    sys_call sys_mprotect_code , %1
%endmacro
%macro sys_munmap 1+
    sys_call sys_munmap_code , %1
%endmacro
%macro sys_brk 1+
    sys_call sys_brk_code , %1
%endmacro
%macro sys_rt_sigaction 1+
    sys_call sys_rt_sigaction_code , %1
%endmacro
%macro sys_rt_sigprocmask 1+
    sys_call sys_rt_sigprocmask_code , %1
%endmacro
%macro sys_rt_sigreturn 1+
    sys_call sys_rt_sigreturn_code , %1
%endmacro
%macro sys_ioctl 1+
    sys_call sys_ioctl_code , %1
%endmacro
%macro sys_pread64 1+
    sys_call sys_pread64_code , %1
%endmacro
%macro sys_pwrite64 1+
    sys_call sys_pwrite64_code , %1
%endmacro
%macro sys_readv 1+
    sys_call sys_readv_code , %1
%endmacro
%macro sys_writev 1+
    sys_call sys_writev_code , %1
%endmacro
%macro sys_access 1+
    sys_call sys_access_code , %1
%endmacro
%macro sys_pipe 1+
    sys_call sys_pipe_code , %1
%endmacro
%macro sys_select 1+
    sys_call sys_select_code , %1
%endmacro
%macro sys_sched_yield 1+
    sys_call sys_sched_yield_code , %1
%endmacro
%macro sys_mremap 1+
    sys_call sys_mremap_code , %1
%endmacro
%macro sys_msync 1+
    sys_call sys_msync_code , %1
%endmacro
%macro sys_mincore 1+
    sys_call sys_mincore_code , %1
%endmacro
%macro sys_madvise 1+
    sys_call sys_madvise_code , %1
%endmacro
%macro sys_shmget 1+
    sys_call sys_shmget_code , %1
%endmacro
%macro sys_shmat 1+
    sys_call sys_shmat_code , %1
%endmacro
%macro sys_shmctl 1+
    sys_call sys_shmctl_code , %1
%endmacro
%macro sys_dup 1+
    sys_call sys_dup_code , %1
%endmacro
%macro sys_dup2 1+
    sys_call sys_dup2_code , %1
%endmacro
%macro sys_pause 1+
    sys_call sys_pause_code , %1
%endmacro
%macro sys_nanosleep 1+
    sys_call sys_nanosleep_code , %1
%endmacro
%macro sys_getitimer 1+
    sys_call sys_getitimer_code , %1
%endmacro
%macro sys_alarm 1+
    sys_call sys_alarm_code , %1
%endmacro
%macro sys_setitimer 1+
    sys_call sys_setitimer_code , %1
%endmacro
%macro sys_getpid 1+
    sys_call sys_getpid_code , %1
%endmacro
%macro sys_sendfile 1+
    sys_call sys_sendfile_code , %1
%endmacro
%macro sys_socket 1+
    sys_call sys_socket_code , %1
%endmacro
%macro sys_connect 1+
    sys_call sys_connect_code , %1
%endmacro
%macro sys_accept 1+
    sys_call sys_accept_code , %1
%endmacro
%macro sys_sendto 1+
    sys_call sys_sendto_code , %1
%endmacro
%macro sys_recvfrom 1+
    sys_call sys_recvfrom_code , %1
%endmacro
%macro sys_sendmsg 1+
    sys_call sys_sendmsg_code , %1
%endmacro
%macro sys_recvmsg 1+
    sys_call sys_recvmsg_code , %1
%endmacro
%macro sys_shutdown 1+
    sys_call sys_shutdown_code , %1
%endmacro
%macro sys_bind 1+
    sys_call sys_bind_code , %1
%endmacro
%macro sys_listen 1+
    sys_call sys_listen_code , %1
%endmacro
%macro sys_getsockname 1+
    sys_call sys_getsockname_code , %1
%endmacro
%macro sys_getpeername 1+
    sys_call sys_getpeername_code , %1
%endmacro
%macro sys_socketpair 1+
    sys_call sys_socketpair_code , %1
%endmacro
%macro sys_setsockopt 1+
    sys_call sys_setsockopt_code , %1
%endmacro
%macro sys_getsockopt 1+
    sys_call sys_getsockopt_code , %1
%endmacro
%macro sys_clone 1+
    sys_call sys_clone_code , %1
%endmacro
%macro sys_fork 1+
    sys_call sys_fork_code , %1
%endmacro
%macro sys_vfork 1+
    sys_call sys_vfork_code , %1
%endmacro
%macro sys_execve 1+
    sys_call sys_execve_code , %1
%endmacro
%macro sys_exit 1+
    sys_call sys_exit_code , %1
%endmacro
%macro sys_wait4 1+
    sys_call sys_wait4_code , %1
%endmacro
%macro sys_kill 1+
    sys_call sys_kill_code , %1
%endmacro
%macro sys_uname 1+
    sys_call sys_uname_code , %1
%endmacro
%macro sys_semget 1+
    sys_call sys_semget_code , %1
%endmacro
%macro sys_semop 1+
    sys_call sys_semop_code , %1
%endmacro
%macro sys_semctl 1+
    sys_call sys_semctl_code , %1
%endmacro
%macro sys_shmdt 1+
    sys_call sys_shmdt_code , %1
%endmacro
%macro sys_msgget 1+
    sys_call sys_msgget_code , %1
%endmacro
%macro sys_msgsnd 1+
    sys_call sys_msgsnd_code , %1
%endmacro
%macro sys_msgrcv 1+
    sys_call sys_msgrcv_code , %1
%endmacro
%macro sys_msgctl 1+
    sys_call sys_msgctl_code , %1
%endmacro
%macro sys_fcntl 1+
    sys_call sys_fcntl_code , %1
%endmacro
%macro sys_flock 1+
    sys_call sys_flock_code , %1
%endmacro
%macro sys_fsync 1+
    sys_call sys_fsync_code , %1
%endmacro
%macro sys_fdatasync 1+
    sys_call sys_fdatasync_code , %1
%endmacro
%macro sys_truncate 1+
    sys_call sys_truncate_code , %1
%endmacro
%macro sys_ftruncate 1+
    sys_call sys_ftruncate_code , %1
%endmacro
%macro sys_getdents 1+
    sys_call sys_getdents_code , %1
%endmacro
%macro sys_getcwd 1+
    sys_call sys_getcwd_code , %1
%endmacro
%macro sys_chdir 1+
    sys_call sys_chdir_code , %1
%endmacro
%macro sys_fchdir 1+
    sys_call sys_fchdir_code , %1
%endmacro
%macro sys_rename 1+
    sys_call sys_rename_code , %1
%endmacro
%macro sys_mkdir 1+
    sys_call sys_mkdir_code , %1
%endmacro
%macro sys_rmdir 1+
    sys_call sys_rmdir_code , %1
%endmacro
%macro sys_creat 1+
    sys_call sys_creat_code , %1
%endmacro
%macro sys_link 1+
    sys_call sys_link_code , %1
%endmacro
%macro sys_unlink 1+
    sys_call sys_unlink_code , %1
%endmacro
%macro sys_symlink 1+
    sys_call sys_symlink_code , %1
%endmacro
%macro sys_readlink 1+
    sys_call sys_readlink_code , %1
%endmacro
%macro sys_chmod 1+
    sys_call sys_chmod_code , %1
%endmacro
%macro sys_fchmod 1+
    sys_call sys_fchmod_code , %1
%endmacro
%macro sys_chown 1+
    sys_call sys_chown_code , %1
%endmacro
%macro sys_fchown 1+
    sys_call sys_fchown_code , %1
%endmacro
%macro sys_lchown 1+
    sys_call sys_lchown_code , %1
%endmacro
%macro sys_umask 1+
    sys_call sys_umask_code , %1
%endmacro
%macro sys_gettimeofday 1+
    sys_call sys_gettimeofday_code , %1
%endmacro
%macro sys_getrlimit 1+
    sys_call sys_getrlimit_code , %1
%endmacro
%macro sys_getrusage 1+
    sys_call sys_getrusage_code , %1
%endmacro
%macro sys_sysinfo 1+
    sys_call sys_sysinfo_code , %1
%endmacro
%macro sys_times 1+
    sys_call sys_times_code , %1
%endmacro
%macro sys_ptrace 1+
    sys_call sys_ptrace_code , %1
%endmacro
%macro sys_getuid 1+
    sys_call sys_getuid_code , %1
%endmacro
%macro sys_syslog 1+
    sys_call sys_syslog_code , %1
%endmacro
%macro sys_getgid 1+
    sys_call sys_getgid_code , %1
%endmacro
%macro sys_setuid 1+
    sys_call sys_setuid_code , %1
%endmacro
%macro sys_setgid 1+
    sys_call sys_setgid_code , %1
%endmacro
%macro sys_geteuid 1+
    sys_call sys_geteuid_code , %1
%endmacro
%macro sys_getegid 1+
    sys_call sys_getegid_code , %1
%endmacro
%macro sys_setpgid 1+
    sys_call sys_setpgid_code , %1
%endmacro
%macro sys_getppid 1+
    sys_call sys_getppid_code , %1
%endmacro
%macro sys_getpgrp 1+
    sys_call sys_getpgrp_code , %1
%endmacro
%macro sys_setsid 1+
    sys_call sys_setsid_code , %1
%endmacro
%macro sys_setreuid 1+
    sys_call sys_setreuid_code , %1
%endmacro
%macro sys_setregid 1+
    sys_call sys_setregid_code , %1
%endmacro
%macro sys_getgroups 1+
    sys_call sys_getgroups_code , %1
%endmacro
%macro sys_setgroups 1+
    sys_call sys_setgroups_code , %1
%endmacro
%macro sys_setresuid 1+
    sys_call sys_setresuid_code , %1
%endmacro
%macro sys_getresuid 1+
    sys_call sys_getresuid_code , %1
%endmacro
%macro sys_setresgid 1+
    sys_call sys_setresgid_code , %1
%endmacro
%macro sys_getresgid 1+
    sys_call sys_getresgid_code , %1
%endmacro
%macro sys_getpgid 1+
    sys_call sys_getpgid_code , %1
%endmacro
%macro sys_setfsuid 1+
    sys_call sys_setfsuid_code , %1
%endmacro
%macro sys_setfsgid 1+
    sys_call sys_setfsgid_code , %1
%endmacro
%macro sys_getsid 1+
    sys_call sys_getsid_code , %1
%endmacro
%macro sys_capget 1+
    sys_call sys_capget_code , %1
%endmacro
%macro sys_capset 1+
    sys_call sys_capset_code , %1
%endmacro
%macro sys_rt_sigpending 1+
    sys_call sys_rt_sigpending_code , %1
%endmacro
%macro sys_rt_sigtimedwait 1+
    sys_call sys_rt_sigtimedwait_code , %1
%endmacro
%macro sys_rt_sigqueueinfo 1+
    sys_call sys_rt_sigqueueinfo_code , %1
%endmacro
%macro sys_rt_sigsuspend 1+
    sys_call sys_rt_sigsuspend_code , %1
%endmacro
%macro sys_sigaltstack 1+
    sys_call sys_sigaltstack_code , %1
%endmacro
%macro sys_utime 1+
    sys_call sys_utime_code , %1
%endmacro
%macro sys_mknod 1+
    sys_call sys_mknod_code , %1
%endmacro
%macro sys_uselib 1+
    sys_call sys_uselib_code , %1
%endmacro
%macro sys_personality 1+
    sys_call sys_personality_code , %1
%endmacro
%macro sys_ustat 1+
    sys_call sys_ustat_code , %1
%endmacro
%macro sys_statfs 1+
    sys_call sys_statfs_code , %1
%endmacro
%macro sys_fstatfs 1+
    sys_call sys_fstatfs_code , %1
%endmacro
%macro sys_sysfs 1+
    sys_call sys_sysfs_code , %1
%endmacro
%macro sys_getpriority 1+
    sys_call sys_getpriority_code , %1
%endmacro
%macro sys_setpriority 1+
    sys_call sys_setpriority_code , %1
%endmacro
%macro sys_sched_setparam 1+
    sys_call sys_sched_setparam_code , %1
%endmacro
%macro sys_sched_getparam 1+
    sys_call sys_sched_getparam_code , %1
%endmacro
%macro sys_sched_setscheduler 1+
    sys_call sys_sched_setscheduler_code , %1
%endmacro
%macro sys_sched_getscheduler 1+
    sys_call sys_sched_getscheduler_code , %1
%endmacro
%macro sys_sched_get_priority_max 1+
    sys_call sys_sched_get_priority_max_code , %1
%endmacro
%macro sys_sched_get_priority_min 1+
    sys_call sys_sched_get_priority_min_code , %1
%endmacro
%macro sys_sched_rr_get_interval 1+
    sys_call sys_sched_rr_get_interval_code , %1
%endmacro
%macro sys_mlock 1+
    sys_call sys_mlock_code , %1
%endmacro
%macro sys_munlock 1+
    sys_call sys_munlock_code , %1
%endmacro
%macro sys_mlockall 1+
    sys_call sys_mlockall_code , %1
%endmacro
%macro sys_munlockall 1+
    sys_call sys_munlockall_code , %1
%endmacro
%macro sys_vhangup 1+
    sys_call sys_vhangup_code , %1
%endmacro
%macro sys_modify_ldt 1+
    sys_call sys_modify_ldt_code , %1
%endmacro
%macro sys_pivot_root 1+
    sys_call sys_pivot_root_code , %1
%endmacro
%macro sys__sysctl 1+
    sys_call sys__sysctl_code , %1
%endmacro
%macro sys_prctl 1+
    sys_call sys_prctl_code , %1
%endmacro
%macro sys_arch_prctl 1+
    sys_call sys_arch_prctl_code , %1
%endmacro
%macro sys_adjtimex 1+
    sys_call sys_adjtimex_code , %1
%endmacro
%macro sys_setrlimit 1+
    sys_call sys_setrlimit_code , %1
%endmacro
%macro sys_chroot 1+
    sys_call sys_chroot_code , %1
%endmacro
%macro sys_sync 1+
    sys_call sys_sync_code , %1
%endmacro
%macro sys_acct 1+
    sys_call sys_acct_code , %1
%endmacro
%macro sys_settimeofday 1+
    sys_call sys_settimeofday_code , %1
%endmacro
%macro sys_mount 1+
    sys_call sys_mount_code , %1
%endmacro
%macro sys_umount2 1+
    sys_call sys_umount2_code , %1
%endmacro
%macro sys_swapon 1+
    sys_call sys_swapon_code , %1
%endmacro
%macro sys_swapoff 1+
    sys_call sys_swapoff_code , %1
%endmacro
%macro sys_reboot 1+
    sys_call sys_reboot_code , %1
%endmacro
%macro sys_sethostname 1+
    sys_call sys_sethostname_code , %1
%endmacro
%macro sys_setdomainname 1+
    sys_call sys_setdomainname_code , %1
%endmacro
%macro sys_iopl 1+
    sys_call sys_iopl_code , %1
%endmacro
%macro sys_ioperm 1+
    sys_call sys_ioperm_code , %1
%endmacro
%macro sys_create_module 1+
    sys_call sys_create_module_code , %1
%endmacro
%macro sys_init_module 1+
    sys_call sys_init_module_code , %1
%endmacro
%macro sys_delete_module 1+
    sys_call sys_delete_module_code , %1
%endmacro
%macro sys_get_kernel_syms 1+
    sys_call sys_get_kernel_syms_code , %1
%endmacro
%macro sys_query_module 1+
    sys_call sys_query_module_code , %1
%endmacro
%macro sys_quotactl 1+
    sys_call sys_quotactl_code , %1
%endmacro
%macro sys_nfsservctl 1+
    sys_call sys_nfsservctl_code , %1
%endmacro
%macro sys_getpmsg 1+
    sys_call sys_getpmsg_code , %1
%endmacro
%macro sys_putpmsg 1+
    sys_call sys_putpmsg_code , %1
%endmacro
%macro sys_afs_syscall 1+
    sys_call sys_afs_syscall_code , %1
%endmacro
%macro sys_tuxcall 1+
    sys_call sys_tuxcall_code , %1
%endmacro
%macro sys_security 1+
    sys_call sys_security_code , %1
%endmacro
%macro sys_gettid 1+
    sys_call sys_gettid_code , %1
%endmacro
%macro sys_readahead 1+
    sys_call sys_readahead_code , %1
%endmacro
%macro sys_setxattr 1+
    sys_call sys_setxattr_code , %1
%endmacro
%macro sys_lsetxattr 1+
    sys_call sys_lsetxattr_code , %1
%endmacro
%macro sys_fsetxattr 1+
    sys_call sys_fsetxattr_code , %1
%endmacro
%macro sys_getxattr 1+
    sys_call sys_getxattr_code , %1
%endmacro
%macro sys_lgetxattr 1+
    sys_call sys_lgetxattr_code , %1
%endmacro
%macro sys_fgetxattr 1+
    sys_call sys_fgetxattr_code , %1
%endmacro
%macro sys_listxattr 1+
    sys_call sys_listxattr_code , %1
%endmacro
%macro sys_llistxattr 1+
    sys_call sys_llistxattr_code , %1
%endmacro
%macro sys_flistxattr 1+
    sys_call sys_flistxattr_code , %1
%endmacro
%macro sys_removexattr 1+
    sys_call sys_removexattr_code , %1
%endmacro
%macro sys_lremovexattr 1+
    sys_call sys_lremovexattr_code , %1
%endmacro
%macro sys_fremovexattr 1+
    sys_call sys_fremovexattr_code , %1
%endmacro
%macro sys_tkill 1+
    sys_call sys_tkill_code , %1
%endmacro
%macro sys_time 1+
    sys_call sys_time_code , %1
%endmacro
%macro sys_futex 1+
    sys_call sys_futex_code , %1
%endmacro
%macro sys_sched_setaffinity 1+
    sys_call sys_sched_setaffinity_code , %1
%endmacro
%macro sys_sched_getaffinity 1+
    sys_call sys_sched_getaffinity_code , %1
%endmacro
%macro sys_set_thread_area 1+
    sys_call sys_set_thread_area_code , %1
%endmacro
%macro sys_io_setup 1+
    sys_call sys_io_setup_code , %1
%endmacro
%macro sys_io_destroy 1+
    sys_call sys_io_destroy_code , %1
%endmacro
%macro sys_io_getevents 1+
    sys_call sys_io_getevents_code , %1
%endmacro
%macro sys_io_submit 1+
    sys_call sys_io_submit_code , %1
%endmacro
%macro sys_io_cancel 1+
    sys_call sys_io_cancel_code , %1
%endmacro
%macro sys_get_thread_area 1+
    sys_call sys_get_thread_area_code , %1
%endmacro
%macro sys_lookup_dcookie 1+
    sys_call sys_lookup_dcookie_code , %1
%endmacro
%macro sys_epoll_create 1+
    sys_call sys_epoll_create_code , %1
%endmacro
%macro sys_epoll_ctl_old 1+
    sys_call sys_epoll_ctl_old_code , %1
%endmacro
%macro sys_epoll_wait_old 1+
    sys_call sys_epoll_wait_old_code , %1
%endmacro
%macro sys_remap_file_pages 1+
    sys_call sys_remap_file_pages_code , %1
%endmacro
%macro sys_getdents64 1+
    sys_call sys_getdents64_code , %1
%endmacro
%macro sys_set_tid_address 1+
    sys_call sys_set_tid_address_code , %1
%endmacro
%macro sys_restart_syscall 1+
    sys_call sys_restart_syscall_code , %1
%endmacro
%macro sys_semtimedop 1+
    sys_call sys_semtimedop_code , %1
%endmacro
%macro sys_fadvise64 1+
    sys_call sys_fadvise64_code , %1
%endmacro
%macro sys_timer_create 1+
    sys_call sys_timer_create_code , %1
%endmacro
%macro sys_timer_settime 1+
    sys_call sys_timer_settime_code , %1
%endmacro
%macro sys_timer_gettime 1+
    sys_call sys_timer_gettime_code , %1
%endmacro
%macro sys_timer_getoverrun 1+
    sys_call sys_timer_getoverrun_code , %1
%endmacro
%macro sys_timer_delete 1+
    sys_call sys_timer_delete_code , %1
%endmacro
%macro sys_clock_settime 1+
    sys_call sys_clock_settime_code , %1
%endmacro
%macro sys_clock_gettime 1+
    sys_call sys_clock_gettime_code , %1
%endmacro
%macro sys_clock_getres 1+
    sys_call sys_clock_getres_code , %1
%endmacro
%macro sys_clock_nanosleep 1+
    sys_call sys_clock_nanosleep_code , %1
%endmacro
%macro sys_exit_group 1+
    sys_call sys_exit_group_code , %1
%endmacro
%macro sys_epoll_wait 1+
    sys_call sys_epoll_wait_code , %1
%endmacro
%macro sys_epoll_ctl 1+
    sys_call sys_epoll_ctl_code , %1
%endmacro
%macro sys_tgkill 1+
    sys_call sys_tgkill_code , %1
%endmacro
%macro sys_utimes 1+
    sys_call sys_utimes_code , %1
%endmacro
%macro sys_vserver 1+
    sys_call sys_vserver_code , %1
%endmacro
%macro sys_mbind 1+
    sys_call sys_mbind_code , %1
%endmacro
%macro sys_set_mempolicy 1+
    sys_call sys_set_mempolicy_code , %1
%endmacro
%macro sys_get_mempolicy 1+
    sys_call sys_get_mempolicy_code , %1
%endmacro
%macro sys_mq_open 1+
    sys_call sys_mq_open_code , %1
%endmacro
%macro sys_mq_unlink 1+
    sys_call sys_mq_unlink_code , %1
%endmacro
%macro sys_mq_timedsend 1+
    sys_call sys_mq_timedsend_code , %1
%endmacro
%macro sys_mq_timedreceive 1+
    sys_call sys_mq_timedreceive_code , %1
%endmacro
%macro sys_mq_notify 1+
    sys_call sys_mq_notify_code , %1
%endmacro
%macro sys_mq_getsetattr 1+
    sys_call sys_mq_getsetattr_code , %1
%endmacro
%macro sys_kexec_load 1+
    sys_call sys_kexec_load_code , %1
%endmacro
%macro sys_waitid 1+
    sys_call sys_waitid_code , %1
%endmacro
%macro sys_add_key 1+
    sys_call sys_add_key_code , %1
%endmacro
%macro sys_request_key 1+
    sys_call sys_request_key_code , %1
%endmacro
%macro sys_keyctl 1+
    sys_call sys_keyctl_code , %1
%endmacro
%macro sys_ioprio_set 1+
    sys_call sys_ioprio_set_code , %1
%endmacro
%macro sys_ioprio_get 1+
    sys_call sys_ioprio_get_code , %1
%endmacro
%macro sys_inotify_init 1+
    sys_call sys_inotify_init_code , %1
%endmacro
%macro sys_inotify_add_watch 1+
    sys_call sys_inotify_add_watch_code , %1
%endmacro
%macro sys_inotify_rm_watch 1+
    sys_call sys_inotify_rm_watch_code , %1
%endmacro
%macro sys_migrate_pages 1+
    sys_call sys_migrate_pages_code , %1
%endmacro
%macro sys_openat 1+
    sys_call sys_openat_code , %1
%endmacro
%macro sys_mkdirat 1+
    sys_call sys_mkdirat_code , %1
%endmacro
%macro sys_mknodat 1+
    sys_call sys_mknodat_code , %1
%endmacro
%macro sys_fchownat 1+
    sys_call sys_fchownat_code , %1
%endmacro
%macro sys_futimesat 1+
    sys_call sys_futimesat_code , %1
%endmacro
%macro sys_newfstatat 1+
    sys_call sys_newfstatat_code , %1
%endmacro
%macro sys_unlinkat 1+
    sys_call sys_unlinkat_code , %1
%endmacro
%macro sys_renameat 1+
    sys_call sys_renameat_code , %1
%endmacro
%macro sys_linkat 1+
    sys_call sys_linkat_code , %1
%endmacro
%macro sys_symlinkat 1+
    sys_call sys_symlinkat_code , %1
%endmacro
%macro sys_readlinkat 1+
    sys_call sys_readlinkat_code , %1
%endmacro
%macro sys_fchmodat 1+
    sys_call sys_fchmodat_code , %1
%endmacro
%macro sys_faccessat 1+
    sys_call sys_faccessat_code , %1
%endmacro
%macro sys_pselect6 1+
    sys_call sys_pselect6_code , %1
%endmacro
%macro sys_ppoll 1+
    sys_call sys_ppoll_code , %1
%endmacro
%macro sys_unshare 1+
    sys_call sys_unshare_code , %1
%endmacro
%macro sys_set_robust_list 1+
    sys_call sys_set_robust_list_code , %1
%endmacro
%macro sys_get_robust_list 1+
    sys_call sys_get_robust_list_code , %1
%endmacro
%macro sys_splice 1+
    sys_call sys_splice_code , %1
%endmacro
%macro sys_tee 1+
    sys_call sys_tee_code , %1
%endmacro
%macro sys_sync_file_range 1+
    sys_call sys_sync_file_range_code , %1
%endmacro
%macro sys_vmsplice 1+
    sys_call sys_vmsplice_code , %1
%endmacro
%macro sys_move_pages 1+
    sys_call sys_move_pages_code , %1
%endmacro
%macro sys_utimensat 1+
    sys_call sys_utimensat_code , %1
%endmacro
%macro sys_epoll_pwait 1+
    sys_call sys_epoll_pwait_code , %1
%endmacro
%macro sys_signalfd 1+
    sys_call sys_signalfd_code , %1
%endmacro
%macro sys_timerfd_create 1+
    sys_call sys_timerfd_create_code , %1
%endmacro
%macro sys_eventfd 1+
    sys_call sys_eventfd_code , %1
%endmacro
%macro sys_fallocate 1+
    sys_call sys_fallocate_code , %1
%endmacro
%macro sys_timerfd_settime 1+
    sys_call sys_timerfd_settime_code , %1
%endmacro
%macro sys_timerfd_gettime 1+
    sys_call sys_timerfd_gettime_code , %1
%endmacro
%macro sys_accept4 1+
    sys_call sys_accept4_code , %1
%endmacro
%macro sys_signalfd4 1+
    sys_call sys_signalfd4_code , %1
%endmacro
%macro sys_eventfd2 1+
    sys_call sys_eventfd2_code , %1
%endmacro
%macro sys_epoll_create1 1+
    sys_call sys_epoll_create1_code , %1
%endmacro
%macro sys_dup3 1+
    sys_call sys_dup3_code , %1
%endmacro
%macro sys_pipe2 1+
    sys_call sys_pipe2_code , %1
%endmacro
%macro sys_inotify_init1 1+
    sys_call sys_inotify_init1_code , %1
%endmacro
%macro sys_preadv 1+
    sys_call sys_preadv_code , %1
%endmacro
%macro sys_pwritev 1+
    sys_call sys_pwritev_code , %1
%endmacro
%macro sys_rt_tgsigqueueinfo 1+
    sys_call sys_rt_tgsigqueueinfo_code , %1
%endmacro
%macro sys_perf_event_open 1+
    sys_call sys_perf_event_open_code , %1
%endmacro
%macro sys_recvmmsg 1+
    sys_call sys_recvmmsg_code , %1
%endmacro
%macro sys_fanotify_init 1+
    sys_call sys_fanotify_init_code , %1
%endmacro
%macro sys_fanotify_mark 1+
    sys_call sys_fanotify_mark_code , %1
%endmacro
%macro sys_prlimit64 1+
    sys_call sys_prlimit64_code , %1
%endmacro
%macro sys_name_to_handle_at 1+
    sys_call sys_name_to_handle_at_code , %1
%endmacro
%macro sys_open_by_handle_at 1+
    sys_call sys_open_by_handle_at_code , %1
%endmacro
%macro sys_clock_adjtime 1+
    sys_call sys_clock_adjtime_code , %1
%endmacro
%macro sys_syncfs 1+
    sys_call sys_syncfs_code , %1
%endmacro
%macro sys_sendmmsg 1+
    sys_call sys_sendmmsg_code , %1
%endmacro
%macro sys_setns 1+
    sys_call sys_setns_code , %1
%endmacro
%macro sys_getcpu 1+
    sys_call sys_getcpu_code , %1
%endmacro
%macro sys_process_vm_readv 1+
    sys_call sys_process_vm_readv_code , %1
%endmacro
%macro sys_process_vm_writev 1+
    sys_call sys_process_vm_writev_code , %1
%endmacro
%macro sys_kcmp 1+
    sys_call sys_kcmp_code , %1
%endmacro
%macro sys_finit_module 1+
    sys_call sys_finit_module_code , %1
%endmacro
; }}}

%endif
