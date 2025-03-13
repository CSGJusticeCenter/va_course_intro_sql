# rename .docx files to more verbose names for upload to sharepoint

# get file path of files rendered
output_files <- as.vector(stringr::str_split(Sys.getenv("QUARTO_PROJECT_OUTPUT_FILES"), "\\\n", simplify = TRUE))

# create new files names 
verbose_file_names <- paste("Intro to SQL - Lesson", stringr::str_sub(output_files, -7, -6),"- text.docx")

# use file names in full paths
renamed_docx_files <- stringr::str_replace(output_files, "lesson[0-9][0-9].docx", verbose_file_names)

# rename!
file.rename(output_files, renamed_docx_files)