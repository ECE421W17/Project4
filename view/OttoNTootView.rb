

require 'gtk2'

require_relative '../model/otto_n_toot.rb'
require_relative '../model/victory'
require_relative '../controller/controller'


# Inspired by lab 9 materials
class OttoNTootView


  T = "T"
  O = "O"

  def initialize

    if __FILE__ == $0
      Gtk.init

      @builder = Gtk::Builder::new
      @builder.add_from_file("otto_n_toot.glade")


     @blankTile = "   "

     @controller = Controller.new([self], :OttoNToot, false)



#
# get the window to terminate the program when it's destroyed
#
      window = @builder.get_object("window1")
      window.signal_connect( "destroy" ) { Gtk.main_quit }

#
# get the menu item "Quit" to terminate the program when activated
#
      menu = @builder.get_object("imagemenuitem5")
      menu.signal_connect( "activate" ) { Gtk.main_quit }

#
# last Step, get the "new" menu item to start a new game
#
      menu = @builder.get_object("menuitem2")
      menu.signal_connect( "activate" ) { setUpTheBoard(:Connect4, true) }

      menu = @builder.get_object("menuitem3")
      menu.signal_connect( "activate" ) { setUpTheBoard(:Connect4, false) }

      menu = @builder.get_object("menuitem5")
      menu.signal_connect( "activate" ) { setUpTheBoard(:OttoNToot, true) }

      menu = @builder.get_object("menuitem6")
      menu.signal_connect( "activate" ) { setUpTheBoard(:OttoNToot, false) }

      #put the CLI here
      menu = @builder.get_object("imagemenuitem10")
      menu.signal_connect( "activate" ) {  }


#
# set all the tiles on the TTT board to a "blank" value.
#   Oh, and connect a signal to each button while we are at it
#
      0.upto(41) { |i|
         @builder.get_object("button" + i.to_s).signal_connect("clicked") {button_clicked(i)};
      }

      setUpTheBoard

      window.show()
      Gtk.main()
    end
  end


  def setUpTheBoard (gameType = :OttoNToot, virtual_player = false)
      @controller = Controller.new([self], gameType, virtual_player)

      0.upto(41) { |i|
         @builder.get_object("button" + i.to_s).set_label(@blankTile);
      }

  end


#
# set up a method to handle a tile being flipped
#
#
  def button_clicked(tileNumber)
    #
    #
    # set up some simple logic to flip the tiles according
    #   to whose turn it is
    #
    #

    if ! @controller.update_model(tileNumber % 7)
      popup ("Column " + (tileNumber%7).to_s + " is full. Try again.")
    end

  end


  def popup(message, destroyBlock = lambda{})

    dialog = Gtk::Dialog.new
    label = Gtk::Label.new(message)
    dialog.vbox.add(label)

    dialog.signal_connect('destroy') {
      destroyBlock.call
    }
    dialog.show_all
    dialog.run
    dialog.destroy

  end


  def update (positions, winner)

    positions.each_with_index do | x, xi |
      x.each_with_index do | y, yi |
        @builder.get_object("button" + (xi*x.length + yi).to_s).set_label(y.to_s)
      end
    end

    if winner != nil
      coordinatesString = ""
      winner.positions.each_with_index do | x, xi |
        coordinatesString += x.to_s + " "
      end
      popup("   Player placing " + winner.winner.category.to_s + " to get pattern " + winner.winner.winning_pattern.to_s + " has won!\n
      Winning moves at coordinates " + coordinatesString + "\n
      Resetting to 2 player OttoNToot", lambda {setUpTheBoard})
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
