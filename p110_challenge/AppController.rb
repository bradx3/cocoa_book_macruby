#
#  AppController.rb
#  p110_challenge
#
#  Created by Brad Wilson on 26/09/08.
#  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
#

class AppController
	attr_accessor :newItemField
	attr_accessor :tableView
	
	def initialize
		@tasks = [ "DD" ]
	end
	
	def createNewItem(sender)
		@tasks << @newItemField.stringValue
		@tableView.reloadData
	end
	
	def numberOfRowsInTableView(sender)
		@tasks.length
	end
	
	def tableView(table, objectValueForTableColumn:col, row:row)
		@tasks[row]
	end
	
	def tableView(table, setObjectValue:object, forTableColumn:column, row:row)
		@tasks[row] = object.to_s
		@tableView.reloadData
	end
end
