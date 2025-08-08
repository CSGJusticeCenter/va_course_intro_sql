## helper script to render entire project to multiple formats
 
# define function to render quarto outputs and vary profile
# as_job set to false - this only works in rstudio and not in positron
render_with_profile <- function(input = NULL, profile, as_job = FALSE) {
  quarto::quarto_render(input = input, profile = profile, as_job = as_job)
}

# possible quarto profiles to render to different formats
# single page html, complete book, word
quarto_profiles <- c("html_lms", "html_book", "docx")

# which lessons do you want to render?
lesson_numbers <- 1:5
lesson_numbers_pad <- stringr::str_pad(lesson_numbers, width = 2, pad = "0")
lessons_to_render <- paste0("lesson", lesson_numbers_pad, "/lesson", lesson_numbers_pad, ".qmd")

# make combinations of lessons and profiles
to_render <- tidyr::crossing(lessons_to_render, quarto_profiles)

# render single lesson, single profile
render_with_profile("lesson18/lesson18.qmd", profile = "docx")

# iterate over lessons and render
purrr::walk(lessons_to_render, \(x) render_with_profile(x, profile = "html_lms"))

# iterate over lessons AND profiles and render
purrr::walk2(
  to_render[[1]], to_render[[2]], 
  \(x, y) render_with_profile(input = x, profile = y)
  )

# iterate over profiles and render all lessons
purrr::walk(quarto_profiles, \(x) render_with_profile(profile = x))
