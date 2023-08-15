.log.print:{[typ;msg]
    -1 typ," ",string[.z.p]," ",$[10=type msg;msg;-3!msg];
    }

.log.info:.log.print "info "
.log.warn:.log.print "warn "
.log.error:.log.print "error"