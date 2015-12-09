import subprocess

def get_terminal_size():
    import os
    env = os.environ
    def ioctl_GWINSZ(fd):
        try:
            import fcntl, termios, struct, os
            cr = struct.unpack('hh', fcntl.ioctl(fd, termios.TIOCGWINSZ,
        '1234'))
        except:
            return
        return cr
    cr = ioctl_GWINSZ(0) or ioctl_GWINSZ(1) or ioctl_GWINSZ(2)
    if not cr:
        try:
            fd = os.open(os.ctermid(), os.O_RDONLY)
            cr = ioctl_GWINSZ(fd)
            os.close(fd)
        except:
            pass
    if not cr:
        cr = (env.get('LINES', 25), env.get('COLUMNS', 80))

    return int(cr[1]), int(cr[0])

width,height = get_terminal_size()

def color_str(string, color_num):
  return '\x1b[3%dm%s\x1b[0m' % (color_num, string)

def colorify(to_color):
  line_styles = ['*', '#']
  for i,style in enumerate(line_styles):
    to_color = to_color.replace(style, color_str(style, i+3))
  return to_color

# Usage
# plots: an array of dictionaries eg: [{"x":[1,2,3],"y":[32,43,57],"title":"Line title"}]
#   title is optional
# width: width of the output
# height: height of the output
def scatter_plot(plots, width=width, height=height):
  gnuplot = subprocess.Popen(["/usr/bin/gnuplot"], 
                             stdin=subprocess.PIPE,
                             stdout=subprocess.PIPE)
  stdinput = []
  stdinput.append(("set term dumb %d %d\n"%(width, height)))
  stdinput.append(("set datafile separator ','\n"))

  # Create the lines and titles
  stdinput.append("plot ")
  for (i,plot) in enumerate(plots):
    title = plot["title"] if "title" in plot else "Line %d" % (i)
    stdinput.append(("'-' using 1:2 title '%s' with lines, " % (title)))
  stdinput.append("\n")

  # Plot the lines
  for plot in plots:
    for i,j in zip(plot["x"],plot["y"]):
       stdinput.append(("%f,%f\n" % (i,j)))
    stdinput.append("e\n")
  
  #gnuplot.stdin.flush()
  out, err = gnuplot.communicate(input=''.join(stdinput).encode('utf-8'))
  
  print(colorify(out.decode('utf-8')))