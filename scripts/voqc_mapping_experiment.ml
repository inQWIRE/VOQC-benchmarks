open Printf
open Voqc.Qasm
open Voqc.Main

(* Code for evaluating VOQC mapping & optimization

  Run with a directory as input (-d). Produces a CSV output "out.csv".
*)

(* From https://rosettacode.org/wiki/Averages/Median#OCaml *)
let median array =
  let len = Array.length array in
    Array.sort compare array;
    (array.((len-1)/2) +. array.(len/2)) /. 2.0

let rec run_timing_trials c num_trials times =
  if num_trials = 0 then times
  else 
    let start = Unix.gettimeofday () in
    match optimize_and_map_to_lnn_ring_16 c with
    | Some _ ->
      let stop = Unix.gettimeofday () in
      run_timing_trials c (num_trials - 1) ((stop -. start) :: times)
    | None -> []

let run_voqc d oc inf =
  let basename = List.nth (String.split_on_char '.' inf) 0 in
  let _ = printf "Processing %s%!\n" basename in
  let (c0, _) = read_qasm (Filename.concat d inf) in
  match optimize_and_map_to_lnn_ring_16 c0 with
  | Some c1 ->
      let times = run_timing_trials c0 11 [] in
      let medtime = median (Array.of_list times) in
      fprintf oc "%s,%d,%d,%d,%d,%f\n" basename (count_2q c0) (count_total c0) 
      (count_2q c1) (count_total c1) medtime
  | None -> failwith "Ill-typed input circuit"

let d = ref ""
let usage = "usage: " ^ Sys.argv.(0) ^ " -d string"
let speclist = [
    ("-d", Arg.Set_string d, ": directory with input programs");
  ]
let () =
  Arg.parse
    speclist
    (fun x -> raise (Arg.Bad ("Bad argument : " ^ x)))
    usage;
if !d = "" then printf "ERROR: Input directory (-d) required.\n" else 
let fs = Sys.readdir !d in
let oc = open_out "out.csv" in
let _ = fprintf oc "Name,Original 2q Count,Original Total Count,Post-Mapping 2q Count,Post-Mapping Total Count,Time (s)\n" in
let _ = Array.iter (run_voqc !d oc) fs in
close_out oc
