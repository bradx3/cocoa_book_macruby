#
#  MyDocument.rb
#  p124_raiseman
#
#  Created by Brad Wilson on 26/09/08.
#  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class MyDocument < NSDocument
	attr_accessor :employees
	
	def init
	
		puts "SDS"
		@employees = []
		super
	end
	
  def windowNibName
    # Implement this to return a nib to load OR implement
    # -makeWindowControllers to manually create your controllers.
    return "MyDocument"
  end

  def dataRepresentationOfType(type)
    # Implement to provide a persistent data representation of your
    # document OR remove this and implement the file-wrapper or file
    # path based save methods.
    return nil
  end

  def loadDataRepresentation_ofType(data, type)
    # Implement to load a persistent data representation of your
    # document OR remove this and implement the file-wrapper or file
    # path based load methods.
    return true
  end
	
end
