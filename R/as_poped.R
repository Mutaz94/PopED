as.poped <- function(filename) {

  converter_path <- system.file("PharmML", package="PopED")
  converter_path <- paste0(converter_path, "/pharmml2poped.exe")
  command <- paste(converter_path, filename, sep=' ')

  stderr <- system2(converter_path, args=c(filename), stdout=FALSE, stderr=TRUE)
  
  if (length(stderr) == 0) {
    stdout <- shell(command, intern=TRUE)

    eval(parse(text=stdout), envir=.GlobalEnv)  
  } else {
    cat(stderr)
  }

  invisible()
}