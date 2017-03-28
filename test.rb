require 'gtk2'

class TestView
    def init
        puts 'In init'
        @command_string = nil
        @output = nil

        # .... -_-
        @output_label = nil 
    end

    def run
        Gtk.init

        # ----- Window -----
        window = Gtk::Window.new("My ruby-gnome2 project")

        window.signal_connect("destroy") {
            puts "destroy event occurred"
            Gtk.main_quit
        }

        window.border_width = 10
        # -----


        # ----- Text input -----
        entry = Gtk::Entry.new()
        entry.signal_connect("insert-text") do |entry, new_character|
            # puts "New text: #{entry.text}#{new_character}"
            @command_string = "#{entry.text}#{new_character}"
        end
        # -----

        # ----- Button -----
        button = Gtk::Button.new("Hello World")
        button.signal_connect("clicked") { 
            puts "HelloWorld"
            puts "Command #{@command_string}"

            # TODO: Run command
            # @output_label.text = "Updated"

            Thread.new do
                @output = `#{@command_string}`
                puts @output

                @output_label.text = @output
            end
        }
        # -----

        # ----- Label -----
        # label = Gtk::Label.new
        @output_label = Gtk::Label.new
        @output_label.text = "Test test test"
        # -----

        vbox = Gtk::VBox.new()
        vbox.pack_start entry, :expand => false, :fill => false, :padding => 0
        vbox.pack_start button, :expand => false, :fill => false, :padding => 0
        vbox.pack_start @output_label, :expand => false, :fill => false, :padding => 0

        window.add(vbox)
        window.show_all 

        Gtk.main
    end
end

tv = TestView.new
tv.run