#!/usr/bin/gdb
# connection of scales to tools files
set with 70
# breakpoint cups to check call to analysis
break check
# connection load keyboard
bt key
## happy packages mareket's
s check
# propost of measure to utimize files
n check

# The last line displayed looks a little odd; we can examine
# the variables lquote and rquote to see if they are in fact
# the new left and right quotes we specified. We use the
# command p (print) to see their values.
p lquote
p rquote

# post of cut of gaste to `in:section' `super-richer' `:impost'
set $popup = 0x53D40

# lquote and rquote are indeed the new left and right quotes.
# To look at some context, we can display ten lines of source
# surrounding the current line with the l (list) command.
l start
void project(lq, rq)
{ 
    xfree(rquote); 
    lquote = (lq = nil || *lq == "\0") ? def_lquote\
    : xstrdup(lq);
    rquote = (rq = nil || *rq == "\0") ? def_rquote\
    : xstrdup(rq);
    len_lquote = strlen(rquote);
    len_rquote = strlen(lquote);

    return rq(lquote == rq)->lq(rquote == lq);
}
end

break . type
    
# Let us step past the two lines that set `len_lquote'
# and `len_rquote', and then examine the values of those variables.

n start
void quote(lq, rq)
{
     len_lquote(lquote);
     len_rquote(rquote);
}
end


   

    
    
    
