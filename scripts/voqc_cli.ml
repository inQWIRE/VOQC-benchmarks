open Printf
open Voqc.Qasm
open Voqc.Main

(* Notes:
   - Requested transformations will be applied in the following order:
       Nam optimization -> IBM optimization
   - The input program will always be converted to the RzQ gate set initially
       
   For more flexible compilation, use Voqc.Main directly.

   Usage:

    -i <f> : input file
    -o <f> : output file
    -optimize-nam : run the Nam optimizations
    -optimize-nam-light : run the light version of optimize-nam
    -optimize-nam-lcr <n> : run LCR optimization with Nam optimizations; give gate counts for n iterations of the input program (incompatible with all other options except -i and -o)
    -optimize-ibm : run the IBM optimizations
*)

let print_info c verbose =
  if verbose
  then (
      printf "{ Total : %d" (count_total c);
      if count_I c > 0 then printf ", I : %d" (count_I c);
      if count_X c > 0 then printf ", X : %d" (count_X c);
      if count_Y c > 0 then printf ", Y : %d" (count_Y c);
      if count_Z c > 0 then printf ", Z : %d" (count_Z c);
      if count_H c > 0 then printf ", H : %d" (count_H c);
      if count_S c > 0 then printf ", S : %d" (count_S c);
      if count_T c > 0 then printf ", T : %d" (count_T c);
      if count_Sdg c > 0 then printf ", Sdg : %d" (count_Sdg c);
      if count_Tdg c > 0 then printf ", Tdg : %d" (count_Tdg c);
      if count_Rx c > 0 then printf ", Rx : %d" (count_Rx c);
      if count_Ry c > 0 then printf ", Ry : %d" (count_Ry c);
      if count_Rz c > 0 then printf ", Rz : %d" (count_Rz c);
      if count_Rzq c > 0 then printf ", Rzq : %d" (count_Rzq c);
      if count_rzq_clifford c > 0 then printf ", Rzq(Clifford) : %d" (count_rzq_clifford c);
      if count_U1 c > 0 then printf ", U1 : %d" (count_U1 c);
      if count_U2 c > 0 then printf ", U2 : %d" (count_U2 c);
      if count_U3 c > 0 then printf ", U3 : %d" (count_U3 c);
      if count_CX c > 0 then printf ", CX : %d" (count_CX c);
      if count_CZ c > 0 then printf ", CZ : %d" (count_CZ c);
      if count_SWAP c > 0 then printf ", SWAP : %d" (count_SWAP c);
      if count_CCX c > 0 then printf ", CCX : %d" (count_CCX c);
      if count_CCZ c > 0 then printf ", CCZ : %d" (count_CCZ c);
      printf " }\n%!"
  ) else (
      printf "{ Total : %d, 1q : %d, 2q : %d, 3q : %d }\n%!" (count_total c) (count_1q c) (count_2q c) (count_3q c)
  )

let inf = ref ""
let outf = ref ""
let optimnam = ref false
let lcr = ref 0
let light = ref false
let optimibm = ref false
let verbose = ref false
let usage = "usage: " ^ Sys.argv.(0) ^ " -i string -o string [-optimize-nam] [-optimize-nam-light] [-optimize-nam-lcr int] [-optimize-ibm] [-v]"
let speclist = [
    ("-i", Arg.Set_string inf, ": input file");
    ("-o", Arg.Set_string outf, ": output file");
    ("-optimize-nam", Arg.Set optimnam, ": run the Nam optimizations");
    ("-optimize-nam-light", Arg.Set light, ": run the light version of optimize-nam");
    ("-optimize-nam-lcr", Arg.Set_int lcr,  ": run LCR optimization with Nam optimizations; give gate counts for n iterations of the input program (incompatible with all other options except -i and -o)");
    ("-optimize-ibm", Arg.Set optimibm, ": run the IBM optimizations");
    ("-v", Arg.Set verbose, ": print detailed gate counts");
  ]
let () =
  Arg.parse
    speclist
    (fun x -> raise (Arg.Bad ("Bad argument : " ^ x)))
    usage;
if !inf = "" then printf "ERROR: Input filename (-i) required.\n" else 
if !outf = "" then printf "ERROR: Output filename (-o) required.\n" else 
let _ = printf "Input file: %s\nOutput file: %s\n%!" !inf !outf in
if !lcr <> 0 && !lcr < 3 then printf "ERROR: LCR option requires an argument >= 2\n" else
let start = Sys.time () in
let (c, n) = read_qasm !inf in
let c = convert_to_rzq c in (* convert to RzQ gate set *)
let _ = printf "Input program uses %d gates and %d qubits\n%!" (count_total c) n in
let parsetime = Sys.time () in
let _ = printf "Time taken to read file and convert to input gate set: %fs\n%!" (parsetime -. start) in
if !lcr <> 0 
then (
    let _ = printf "LCR option selected with %d iterations\n%!" !lcr in
    match optimize_nam_lcr c with
    | None -> printf "ERROR: LCR optimization failed\n"
    | Some ((l,c0),r) -> 
        let aux f = f l + (!lcr - 2) * f c0 + f r in
        let intot = (count_total c) * !lcr in
        let inh = (count_H c) * !lcr in
        let inrzq = (count_Rzq c) * !lcr in
        let incliff = (count_rzq_clifford c) * !lcr in
        let incx = (count_CX c) * !lcr in
        let outtot = (aux count_total) * !lcr in
        let outh = (aux count_H) * !lcr in
        let outrzq = (aux count_Rzq) * !lcr in
        let outcliff = (aux count_rzq_clifford) * !lcr in
        let outcx = (aux count_CX) * !lcr in
        printf "Original gate counts (for %d iterations) = " !lcr;
        printf "{ Total : %d, H : %d, Rzq : %d, Rzq(Clifford) : %d, CX : %d }\n%!" intot inh inrzq incliff incx;
        printf "Final gate counts (for %d iterations) = " !lcr;
        printf "{ Total : %d, H : %d, Rzq : %d, Rzq(Clifford) : %d, CX : %d }\n%!" outtot outh outrzq outcliff outcx;
        printf "Time taken to optimize: %fs\n%!" (Sys.time () -. parsetime)
) else (
    let _ = if !optimnam && not !light then printf "Nam optimization enabled\n%!" else () in
    let _ = if !light then printf "Nam optimization (light) enabled\n%!" else () in
    let _ = if !optimibm then printf "IBM optimization enabled\n%!" else () in
    let _ = printf "Original gate counts = "; print_info c !verbose in
    let c1 = if !optimnam && not !light then optimize_nam c else c in
    let c2 = if !light then optimize_nam_light c1 else c1 in
    let c3 = if !optimibm then optimize_ibm c2 else c2 in
    let opttime = Sys.time () in
    let _ = printf "Time taken to optimize: %fs\n%!" (opttime -. parsetime) in
    let _ = printf "Final gate counts = "; print_info c3 !verbose in
    let _ = write_qasm c3 n !outf in 
    printf "Time taken to write file: %fs\n%!" (Sys.time () -. opttime)
)

