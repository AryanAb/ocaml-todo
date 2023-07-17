val print_error : string -> unit

val create_file_if_needed : unit -> unit

val list : unit -> unit

val add : string option -> unit
val add_helper : string -> unit

val remove : string option -> unit
val remove_helper : int -> unit

val do_command : string -> string option -> unit