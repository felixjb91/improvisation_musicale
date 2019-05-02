open Notes

let typed_note_of_string str =
  let vals = String.split_on_char '-' str in
  note_factory_type (
    note_factory 
      (string_to_noteName(List.nth vals 0)) 
      (string_to_alteration(List.nth vals 1)) 
      (int_of_string(List.nth vals 2))
  ) (string_to_noteType(List.nth vals 3))

let typed_note_list_of_string str =
  let typed_notes_string_list = String.split_on_char ';' str in 
  let typed_notes_list = 
    List.map (fun x -> 
        if String.length x > 4 then 
          typed_note_of_string x else typed_note_of_string "Rest-Becarre-4-Noire"
      ) typed_notes_string_list 
  in typed_notes_list