# Loads PharmML as PopED. If out_file is given, script is generated (but not
# executed). If out_file is "" or "same", the basename of PharmML is used.
as.poped <- function(filename, out_file=NULL) {

    converter_path <- system.file("PharmML", package="PopED")
    converter_path <- paste0(converter_path, "/pharmml2poped.exe")
    command <- paste(converter_path, filename, sep=' ')

    stdout <- system2(converter_path, args=c(filename), stdout=TRUE, stderr="")

    if (is.null(out_file)) {
        eval(parse(text=stdout), envir=.GlobalEnv)
    } else {
        if (out_file == "" || tolower(out_file) == "same") {
            out_file = sub("^(.*)??(\\.[[:alnum:]]+)?$", "\\1.R", filename)
        }
        tryCatch({
            suppressWarnings(write(stdout, file=out_file))
        }, error=function(e){ cat(paste0(e, " (for file '", out_file, "')")) })
    }
    invisible()
}

