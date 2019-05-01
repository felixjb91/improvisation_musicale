open Notes

(* Test note_factory *)

let note_1 = note_factory Do Diese 3

let test_note_factory_1 () =
  Alcotest.(check char) "same nom"  'Do' note_1.nom
  Alcotest.(check char) "same alter"  'Diese' note_1.alter
  Alcotest.(check char) "same octave"  '3' note_1.octave

let note_2 = note_factory Mi Diese 1

let test_note_factory_2 () =
  Alcotest.(check char) "same nom"  'Do' note_2.nom
  Alcotest.(check char) "same alter"  'Becarre' note_2.alter
  Alcotest.(check int) "same octave"  1 note_2.octave

(* Test note_factory_type *)

let typed_note = note_factory_type note_1 Noire

let test_note_factory_type_1 () =
  Alcotest.(check char) "same type_de_note"  'Noire' typed_note.type_de_note

(* Test nomNote2num *)

let nomNote2num = nomNote2num Fa

let nomNote2num_1 () =
  Alcotest.(check int) "same num"  5 nomNote2num

(* Test numNote2nom *)

let numNote2nom = numNote2nom 5

let numNote2nom_1 () =
  Alcotest.(check char) "same nom"  'Fa' numNote2nom

(* Test noteType2duree *)

let noteType2duree = noteType2duree 1 typed_note

let noteType2duree_1 () =
  Alcotest.(check float) "same nom"  60.0 noteType2duree

(* Test note2midi *)

let note2midi = note2midi typed_note

let note2midi_1 () =
  Alcotest.(check float) "same nom" 1 note2midi

let test_set = [
  "test 1" , `Quick, test_note_factory_1;
  "test 2" , `Quick, test_note_factory_2;
  "test 3" , `Quick, test_note_factory_type_1;
  "test 4" , `Quick, nomNote2num_1;
  "test 5" , `Quick, numNote2nom_1;
  "test 6" , `Quick, noteType2duree_1;
  "test 7" , `Quick, note2midi_1;
]

let () =
  Alcotest.run "My first test" [
    "test_set", test_set;
  ]