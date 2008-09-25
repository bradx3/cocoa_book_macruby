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
	
	def initialize()
		@speaker = NSSpeechSynthesizer.new
	end
	
	def say(sender)
		str = @text_field.stringValue()
		@speaker.startSpeakingString(str)
	end
	
	def stop(sender)
		@speaker.stopSpeaking()
	end
end
