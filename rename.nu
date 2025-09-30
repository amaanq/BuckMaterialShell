#!/usr/bin/env nu

def rename-if-exists [old: string, new: string] {
   if ($old | path exists) {
      mv $old $new
      print $"  ✓ ($old) -> ($new)"
      true
   } else {
      false
   }
}

def main [] {
   print "Renaming DankMaterialShell to Buck..."

   print "\nRenaming directories..."
   let dir_renames = [
      { old: "Modules/DankBar",  new: "Modules/BuckBar",  name: "DankBar directory"  }
      { old: "Modules/DankDash", new: "Modules/BuckDash", name: "DankDash directory" }
   ]
   $dir_renames | each { |item|
      if not (rename-if-exists $item.old $item.new) {
         print $"  ($item.name) not found - already renamed)"
      }
   }

   print "\nRenaming any remaining Dank* directories..."
   let dank_dirs = (ls -a **/* | where type == dir | where name =~ "Dank|dank" | get name)
   if ($dank_dirs | length) > 0 {
      $dank_dirs | each { |dir|
         let new_dir = ($dir | str replace -a "Dank" "Buck" | str replace -a "dank" "buck")
         if $dir != $new_dir {
            mv $dir $new_dir
            print $"  ✓ ($dir) -> ($new_dir)"
         }
      }
   }

   print "\nRenaming Dank/DMS*.qml files..."
   let all_dank_files = (glob **/{Dank,DMS}*.qml)
   if ($all_dank_files | length) > 0 {
      $all_dank_files | each { |file|
         let dir = ($file | path dirname)
         let name = ($file | path basename)
         let new_name = (
            $name
            | str replace "Dank" "Buck"
            | str replace "DMS" "Dykwabi"
         )
         let new_path = ($dir | path join $new_name)
         mv $file $new_path
         print $"  ✓ ($file) -> ($new_path)"
      }
   } else {
      print "  (no Dank*.qml files found - already renamed)"
   }

   print "\nRenaming asset files..."
   let file_renames = [
      { old: "assets/dank.svg",             new: "assets/buck.svg",             name: "dank.svg"  }
      { old: "matugen/configs/dank.toml",   new: "matugen/configs/buck.toml",   name: "dank.toml" }
      { old: "matugen/dank16.py",           new: "matugen/buck16.py",           name: "dank16.py" }
      { old: "matugen/templates/dank.json", new: "matugen/templates/buck.json", name: "dank.json" }
   ]
   $file_renames | each { |item|
      if not (rename-if-exists $item.old $item.new) {
         print $"  ($item.name) not found - already renamed)"
      }
   }

   print "\nReplacing references in files..."
   let all_files = (glob **/*.{qml,js,md,toml,css,conf,json,sh,kdl,py,nix,colors,service,spec} | append "dms-greeter")
   $all_files | each { |file|
      try {
         let content = (open $file --raw | decode utf-8)
         let new_content = ($content
            | str replace -a "DMS_" "DYKWABI_"
            | str replace -a "DMS" "Dykwabi"
            | str replace -a "dms" "dykwabi"
            | str replace -a "DANK" "BUCK"
            | str replace -a "Dank" "Buck"
            | str replace -a "dank" "buck"
            | str replace -a "github:AvengeMedia/bucklinux" "github:amaanq/dykwabi"
            | str replace -a "AvengeMedia/bucklinux" "amaanq/dykwabi"
         )
         if $content != $new_content {
            $new_content | save -f $file
            print $"  ✓ ($file)"
         }
      } catch {
         print $"Failed to read ($file)"
      }
   }

   print "\nApplying patches..."
   if ("patches" | path exists) {
      let patch_files = (ls patches/*.patch | get name)
      if ($patch_files | length) > 0 {
         $patch_files | each { |patch|
            print $"  Applying ($patch)..."
            try {
               ^patch -p1 --forward --reject-file=- -i $patch
               print $"  ✓ ($patch) applied"
            } catch {
               print $"  ✗ Failed to apply ($patch)"
            }
         }
      } else {
         print "  (no patch files found)"
      }
   } else {
      print "  (patches directory not found)"
   }

   print "\nRenaming complete"

   ^nix flake check
}
