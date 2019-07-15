## Freeswitch sample configuration for various usecases


### Sofia commands
```sh
sofia profile external rescan reloadxml
```

gateway status 

sofia profile external gwlist up
sipcall_41449999990

sofia profile external gwlist down
52.152.177.149 voxbeam_outbound

### fs_cli
Viewing preset freeswitch variables by fs_cli eval $${variable}.  Can view value of 
      hostname
      local_ip_v4
      local_mask_v4
      local_ip_v6
      switch_serial
      base_dir
      recordings_dir
      sound_prefix
      sounds_dir
      conf_dir
      log_dir
      run_dir
      db_dir
      mod_dir
      htdocs_dir
      script_dir
      temp_dir
      grammar_dir
      certs_dir
      storage_dir
      cache_dir
      core_uuid
      zrtp_enabled
      nat_public_addr
      nat_private_addr
      nat_type

