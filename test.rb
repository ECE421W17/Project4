require 'gtk2'

# Gtk.init
window = Gtk::Window.new("My ruby-gnome2 project")

button = Gtk::Button.new("Hello World")
button.signal_connect("clicked") { 
    puts "HelloWorld"
}

window.signal_connect("destroy") {
    puts "destroy event occurred"
    Gtk.main_quit
}

window.border_width = 10
window.add(button)
window.show_all

Gtk.main