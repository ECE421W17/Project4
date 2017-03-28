

require 'gtk2'

class OttoNTootView


  X = "X"
  O = "O"

  def initialize

    if __FILE__ == $0
      Gtk.init

# Call this function before using any other GTK+ functions in your GUI
# applications. It will initialize everything needed to operate the toolkit
# and parses some standard #command line options. argv are adjusted accordingly
#so your own code will never see those standard arguments. # attr :glade

      @builder = Gtk::Builder::new
#http://ruby-gnome2.sourceforge.jp/hiki.cgi?Gtk%3A%3ABuilder
      @builder.add_from_file("otto_n_toot.glade")
     # @builder.connect_signals{ |handler| method(handler) }  # (No handlers yet, but I will have eventually)


     @blankTile = "   "




#
# Step 1: get the window to terminate the program when it's destroyed
#
      window = @builder.get_object("window1")
      window.signal_connect( "destroy" ) { Gtk.main_quit }

#
# Step 2: get the menu item "Quit" to terminate the program when activated
#
      menu = @builder.get_object("imagemenuitem5")
      menu.signal_connect( "activate" ) { Gtk.main_quit }

#
# Step 9: last Step, get the "new" menu item to start a new game
#
      menu = @builder.get_object("menuitem2")
      menu.signal_connect( "activate" ) { setUpTheBoard }


#
# Step 3: set all the tiles on the TTT board to a "blank" value.
#   Oh, and connect a signal to each button while we are at it
#
      0.upto(41) { |i|
         @builder.get_object("button" + i.to_s).signal_connect("clicked") {button_clicked(i)};
      }

#
# Step 8: We'll say that X has the first move
#
#
      setUpTheBoard

      window.show()
      Gtk.main()
    end
  end


  def setUpTheBoard

      0.upto(41) { |i|
         @builder.get_object("button" + i.to_s).set_label(@blankTile);
      }
      @x = 0
      @o = 1
      @turn = @x
  end


#
# Step 4: set up a method to handle a tile being flipped
#
#
  def button_clicked(tileNumber)
   #
   #
   # Step 5: set up some simple logic to flip the tiles according
   #   to whose turn it is
   #
   #

    tmp = @builder.get_object("button" + tileNumber.to_s).label
    if tmp == @blankTile
       if @turn == @x
          @turn = @o
          @builder.get_object("button" + tileNumber.to_s).set_label(X)
       else
          @turn = @x
          @builder.get_object("button" + tileNumber.to_s).set_label(O)
       end
    end

    if win?
      system("clear")
      if @turn == @x
        popup ("Player O is the winner")
      else
        popup ("Player X is the winner")
      end
    end
  end


  def popup(message)

    dialog = Gtk::Dialog.new
    label = Gtk::Label.new(message)
    dialog.vbox.add(label)
    # Following is a button to the dialog that allows user to restart. Unsure if
    # desired. Isn't currently able to close the dialog after clicking
    # button = Gtk::Button.new("New 2 Player")
    # button.signal_connect('clicked') {
    #   setUpTheBoard
    # }
    # dialog.vbox.add(button)
    dialog.show_all
    dialog.run
    dialog.destroy

  end


#
# Step 6: Write a method to determine if we have a winning board. We'll do it the
#         "brute force" way for illestration purposes
#
#        Exercise: What is a more elegant way to do this? (Hint: magic square)
#
#
  def win?

     return threes(1,2,3) ||
            threes(4,5,6) ||
            threes(7,8,9) ||
            threes(1,4,7) ||
            threes(2,5,8) ||
            threes(3,6,9) ||
            threes(1,5,9) ||
            threes(7,5,3)
  end


#
# Step 7: Write a method to determine if any 3 given tiles are a winning combination
#
#
#
  def threes(a,b,c)

    t1 = @builder.get_object("button" + a.to_s).label
    t2 = @builder.get_object("button" + b.to_s).label
    t3 = @builder.get_object("button" + c.to_s).label
    return (t1 != @blankTile && t2 != @blankTile && t3 != @blankTile) && (t1 == t2 && t2 == t3)

  end


  def gtk_main_quit
    puts "Say goodnight Gracie!"
    Gtk.main_quit()
  end


end


hello = OttoNTootView.new

#References
#http://ruby-gnome2.sourceforge.jp/hiki.cgi?tut-gtk2-dynui-bui#Creating+the+Window
#http://ruby-gnome2.sourceforge.jp/hiki.cgi?Gtk#Gtk.main
