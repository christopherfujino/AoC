#!/usr/bin/env ocaml

let () =
  let lines = In_channel.open_text "input.txt" |> In_channel.input_lines in
  let (_, zeroes) =
    List.fold_left
      (fun (pos, zeroes) line ->
        let direction = String.sub line 0 1 in
        let distance =
          String.sub line 1 (String.length line - 1) |> int_of_string
        in
        let pos =
          match direction with
          | "L" -> pos - distance
          | "R" -> pos + distance
          | _ -> failwith "Unreachable"
        in
        let pos = pos mod 100 in
        let zeroes = if pos = 0 then zeroes + 1 else zeroes in
        (pos, zeroes))
      (50, 0) lines
  in
  Printf.printf "Number of zeroes: %d\n" zeroes
