#!/usr/bin/env ocaml

let validate i =
  let str = string_of_int i in
  let len = String.length str in
  if len mod 2 = 0 then
    let half_len = len / 2 in
    let first_half = String.sub str 0 half_len in
    let second_half = String.sub str half_len half_len in
    String.compare first_half second_half != 0
  else true

let () =
  let text = In_channel.open_text "input.txt" |> In_channel.input_all in
  let ids = String.split_on_char ',' text in
  let invalid_ids =
    List.fold_left
      (fun invalid_ids id_range ->
        let id_range = String.split_on_char '-' id_range in
        if not (List.length id_range = 2) then failwith "Unreachable!"
        else
          let start = List.nth id_range 0 |> int_of_string in
          let ender = List.nth id_range 1 |> String.trim |> int_of_string in
          let rec iter invalid_ids cur =
            if cur > ender then invalid_ids
            else
              let invalid_ids =
                if not (validate cur) then cur :: invalid_ids else invalid_ids
              in
              iter invalid_ids (cur + 1)
          in
          iter invalid_ids start)
      [] ids
  in
  let sum = List.fold_left (fun sum cur -> sum + cur) 0 invalid_ids in
  Printf.printf "%d\n" sum
