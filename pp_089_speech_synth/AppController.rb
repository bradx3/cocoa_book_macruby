#
#  AppController.rb
#  speech_synth
#
#  Created by Brad Wilson on 25/09/08.
#  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
#

class AppController
	attr_accessor :speaker
	attr_accessor :text_field
	attr_accessor :start_button
	attr_accessor :stop_button
	
	def initialize()
		@speaker = NSSpeechSynthesizer.new
		@speaker.setDelegate(self)
	end
	
	def say(sender)
		str = @text_field.stringValue()
		@speaker.startSpeakingString(str)
		@stop_button.setEnabled(true)
		@start_button.setEnabled(false)
	end
	
	def stop(sender)
		@speaker.stopSpeaking()
	end
	
	def speechSynthesizer(sender, didFinishSpeaking:bool)
		@stop_button.setEnabled(false)
		@start_button.setEnabled(true)
	end
	
end
