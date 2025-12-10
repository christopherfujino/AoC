#!/usr/bin/env ocaml

let find_second =
  Bytes.fold_left
    (fun highest cur ->
      let i = Char.code cur - 48 in
      if i > highest then i else highest)
    0

let find_first line =
  let bytes' = String.to_bytes line in
  let len = Bytes.length bytes' in
  let highest = ref 0 in
  let highest_indices = ref [] in
  Bytes.iteri
    (fun idx b ->
      if idx > len - 2 then ()
      else
        let i = Char.code b - 48 in
        if i >= !highest then
          let subbytes = Bytes.sub bytes' (idx + 1) (len - (idx + 1)) in
          let two_digit_i = (i * 10) + find_second subbytes in
          if i > !highest then (
            highest_indices := [ two_digit_i ];
            highest := i)
          else highest_indices := two_digit_i :: !highest_indices)
    bytes';
  List.fold_left
    (fun highest current -> if current > highest then current else highest)
    0 !highest_indices

let () =
  let lines = In_channel.open_text "input.txt" |> In_channel.input_lines in
  let sum = List.fold_left (fun sum line -> sum + find_first line) 0 lines in
  Printf.printf "%d\n" sum
