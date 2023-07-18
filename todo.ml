open Core
open Stdio

let print_error text =
  Stdio.print_endline ("\027[1;38;5;196mError\027[0m: " ^ text)

let create_file_if_needed () =
  match Sys_unix.file_exists "./.todo" with 
  | `No | `Unknown -> Out_channel.write_all "./.todo" ~data:""
  | `Yes -> ()

let list () = 
  let inc = In_channel.create "./.todo" in
  List.iter (In_channel.input_lines inc) ~f:Stdio.print_endline;
  In_channel.close inc

let add_helper itinerary =
  let outc = Out_channel.create ~append:true "./.todo" in
  Out_channel.fprintf outc "%s\n" itinerary;
  Out_channel.close outc

let add = function
  | Some x -> add_helper x
  | None -> print_error "No task provided"

let remove_helper line_num =
  let inc = In_channel.create "./.todo" in
  let lines = List.filteri (In_channel.input_lines inc) ~f:(fun i _ -> i <> line_num - 1) in
  Out_channel.write_lines "./.todo" lines;
  In_channel.close inc

let remove = function
  | Some x -> remove_helper (int_of_string x)
  | None -> print_error "No line number provided"

let do_command command_type params =
  match command_type with
  | "list" | "ls" -> list ()
  | "add" -> add params
  | "remove" | "rm" -> remove params
  | _ -> print_error "Command type not found"

let command =
  let readme_str = 
    "These are the todo commands used in various situation

    add             adds a task to the to-do list as defined by [PARAMS]
    list, ls        lists current tasks on the to-do list
    remove, rm      removes the task on the line number as specified by [PARAMS]

    To see specific examples, check https://github.com/AryanAb/ocaml-todo
    " 
  in
  Command.basic
  ~summary:"A CLI tool to manage your to-do list"
  ~readme:(fun () -> readme_str)
  (let%map_open.Command
    command_type = anon ("type" %: string) and
    params = anon (maybe ("param" %: string)) 
  in
  fun () -> do_command command_type params)

let () =
  create_file_if_needed ();
  Command_unix.run ~version:"1.0" command