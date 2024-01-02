{
  users.mutableUsers = false;
  users.users = {
    root = {
      initialHashedPassword = "$6$57BFBDSN659fkxQd$x9eVCknZbKd./8rrUyobvtyruVx51y7CSBRodDn4tDlltJ3lQVKQkIrzQlYX9R5PsfVBbdQGNOB19.3D.BCi.1";
      openssh.authorizedKeys.keys = [ ];
    };
    jtdoepke = {
      isNormalUser = true;
      home = "/home/jtdoepke";
      description = "Jaye Doepke";
      group = "jtdoepke";
      uid = 1000;
      initialHashedPassword = "$6$OU8N2t0gDaW6eYCp$pBsUQm3zz5szeskXlLzn0ssjaMm6VGg.Vzka1fTq26jPr5wK39tLrcDNTNt6U1SM6/urOtf68J6D4WhKrFWym1";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICkQZ8V2cVdXdM3q4bSb9fgvEaCpqJYBWSwy6FjjqaJV"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjJhKbiyNstn9bsvldrWsYBWXgpva0hCoxj9pYUUBpL"
      ];
    };
  };
  users.groups = {
    jtdoepke = {
      gid = 1000;
    };
  };
}
