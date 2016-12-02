# Loads PharmML as PopED. If out_file is given, script is generated (but not
# executed). If out_file is "" or "same", the basename of PharmML is used.
as.poped <- function(filename, out_file=NULL) {

    converter_path <- system.file("PharmML", package="PopED")
    if (Sys.info()['sysname'] == 'Linux') {
        converter_path <- paste0(converter_path, "/pharmml2poped")
    } else {
        converter_path <- paste0(converter_path, "/pharmml2poped.exe")
    }
    command <- paste(converter_path, filename, sep=' ')

    err <- system2(converter_path, args=c(filename), stdout=F, stderr=T)
    invisible(lapply(err, warning, call.=F))
    out <- system2(converter_path, args=c(filename), stdout=T, stderr=F)
    
    if (is.null(out_file)) {
        tryCatch(eval(parse(text=out), envir=.GlobalEnv),
                 error=function(e){ warning("Fatal: Could not load conversion result", call.=F) });
    } else {
        if (out_file == "" || tolower(out_file) == "same") {
            out_file = sub("^(.*)??(\\.[[:alnum:]]+)?$", "\\1.R", filename)
        }
        tryCatch({
            suppressWarnings(write(out, file=out_file))
        }, error=function(e){ warning(paste0(e, " Is file '", out_file, "' writeable?"), call.=F) })
    }
    invisible()
}

