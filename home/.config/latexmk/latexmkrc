$dvi_previewer = 'start zathura';
$ps_previewer  = 'start zathura';
$pdf_previewer = 'start zathura';


$success_cmd = "nvim --remote-expr 'vimtex#compiler#callback(1)'";
$failure_cmd = "nvim --remote-expr 'vimtex#compiler#callback(0)'";


$compiling_cmd = "xdotool search --name \"%D\" " .
                "set_window --name \"%D compiling...\"";
$success_cmd   = "xdotool search --name \"%D\" " .
                "set_window --name \"%D OK\"";
$failure_cmd   = "xdotool search --name \"%D\" " .
                   "set_window --name \"%D FAILURE\"";

$pdflatex = 'pdflatex -synctex=1 %O %S';
