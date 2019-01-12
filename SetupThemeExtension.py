#!/usr/bin/python
import os
import shutil


def do_I_have_this_folder(path):
  if os.path.isdir(path):
    return True
  else:
    return False


def validate_create_update_template_folder(template_folder_path):
  folder_to_move = "Theme Extension.xctemplate"
  folder_path = template_folder_path + "/" + folder_to_move

  if do_I_have_this_folder(template_folder_path):
    print("\nFolder exist don't need to create :D\nCopying only to make sure you have the last version ;)\n")
    if do_I_have_this_folder(folder_path):
      shutil.rmtree(folder_path)

    shutil.copytree(folder_to_move, folder_path)
    print("Done, updated :D :D\n")
  else:
    print("\nNo folder created yeat, creating....")
    os.makedirs(template_folder_path)
    if do_I_have_this_folder(template_folder_path):
      print("\nFolder created copying Theme Extension template...")

      shutil.copytree(folder_to_move, folder_path)
      # This path is to check if file / folder is there and moved with success
      template_folder = "{}/Library/Developer/Xcode/Templates/Theme Extension.xctemplate".format(os.environ['HOME'])
      if do_I_have_this_folder(template_folder):
        print("\nFolder copy success :) enjoy\n")
      else:
        print("\nMove problem, didn't worked :(\n")
    else:
      print("\nSomething when wrong when trying to create folder :(\n")


# Check if folder is there, if not move, if already there move again to make sure is updated
templates_folder = "{}/Library/Developer/Xcode/Templates".format(os.environ['HOME'])
validate_create_update_template_folder(templates_folder)
