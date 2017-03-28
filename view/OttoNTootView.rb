

require 'gtk2'

require_relative '../model/otto_n_toot.rb'
require_relative '../model/victory'
require_relative '../controller/controller'

class OttoNTootView


  T = "T"
  O = "O"

  def initialize

    if __FILE__ == $0
      Gtk.init

# Call this function before using any other GTK+ functions in your GUI
# applications. It will initialize everything needed to operate the toolkit
# and parses some standard #command line options. argv are adjusted accordingly
# so your own code will never see those standard arguments. # attr :glade

      @builder = Gtk::Builder::new
#http://ruby-gnome2.sourceforge.jp/hiki.cgi?Gtk%3A%3ABuilder
      @builder.add_from_file("otto_n_toot.glade")
     # @builder.connect_signals{ |handler| method(handler) }  # (No handlers yet, but I will have eventually)


     @blankTile = "   "

    #  @controller = Controller.new(self, OttoNToot)


    # game = Game.new
    # game.make_move(@o, 1)



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
      menu = @builder.get_object("menuitem3")
      menu.signal_connect( "activate" ) { setUpTheBoard }


#
# Step 3: set all the tiles on the TTT board to a "blank" value.
#   Oh, and connect a signal to each button while we are at it
#
      0.upto(41) { |i|
         @builder.get_object("button" + i.to_s).signal_connect("clicked") {button_clicked(i)};
      }

#
# Step 8: We'll say that T has the first move
#
#
      setUpTheBoard

      window.show()
      Gtk.main()
    end
  end


  def setUpTheBoard (otherPlayer = Player)
      # @controller = Controller.new(self, OttoNToot, otherPlayer)
      # 0.upto(41) { |i|
      #    @builder.get_object("button" + i.to_s).set_label(@blankTile);
      # }
      # @t = 0
      # @o = 1
      # @turn = @t
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
       if @turn == @t
          @turn = @o
          # @builder.get_object("button" + tileNumber.to_s).set_label(T)
          Gtk.modify@builder.get_object("button" + tileNumber.to_s)
       else
          @turn = @t
          @builder.get_object("button" + tileNumber.to_s).set_label(O)
       end
    end

    if win?
      system("clear")
      if @turn == @t
        popup ("Player O is the winner")
      else
        popup ("Player T is the winner")
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


  def update (positions, winner)
    puts positions

    positions.each_with_index do | x, xi |
      x.each_with_index do | y, yi |
        @builder.get_object("button" + (xi*length(x) + yi)).set_label(y)
      end
    end

    if winner != nil
      # winner.positions.each_with_index do | x, xi |
      #   if xi % 2 != 0
      #     next
      #   else
      #     # Set color somehow
      #     @builder.get_object("button" + (x*length(positions[0]) + winner.positions[xi + 1])).
      #   end
      # end
      popup("Player placing " + winner.winner.category + " to get pattern " + winner.winner.pattern + " has won!"
    end
  end


  def gtk_main_quit
    Gtk.main_quit()
  end


end


hello = OttoNTootView.new

#References
#http://ruby-gnome2.sourceforge.jp/hiki.cgi?tut-gtk2-dynui-bui#Creating+the+Window
#http://ruby-gnome2.sourceforge.jp/hiki.cgi?Gtk#Gtk.main
