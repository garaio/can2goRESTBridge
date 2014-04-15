```shell

				 $$$$$$\                       $$$$$$\   $$$$$$\                                 
				$$  __$$\                     $$  __$$\ $$  __$$\                                
				$$ /  \__| $$$$$$\  $$$$$$$\  \__/  $$ |$$ /  \__| $$$$$$\                       
				$$ |       \____$$\ $$  __$$\  $$$$$$  |$$ |$$$$\ $$  __$$\                      
				$$ |       $$$$$$$ |$$ |  $$ |$$  ____/ $$ |\_$$ |$$ /  $$ |                     
				$$ |  $$\ $$  __$$ |$$ |  $$ |$$ |      $$ |  $$ |$$ |  $$ |                     
				\$$$$$$  |\$$$$$$$ |$$ |  $$ |$$$$$$$$\ \$$$$$$  |\$$$$$$  |                     
				\______/  \_______|\__|  \__|\________| \______/  \______/                      
                                                                                             
                                                                                             
	$$$$$$$\  $$$$$$$$\  $$$$$$\ $$$$$$$$\ $$$$$$$\            $$\       $$\                     
	$$  __$$\ $$  _____|$$  __$$\\__$$  __|$$  __$$\           \__|      $$ |                    
	$$ |  $$ |$$ |      $$ /  \__|  $$ |   $$ |  $$ | $$$$$$\  $$\  $$$$$$$ | $$$$$$\   $$$$$$\  
	$$$$$$$  |$$$$$\    \$$$$$$\    $$ |   $$$$$$$\ |$$  __$$\ $$ |$$  __$$ |$$  __$$\ $$  __$$\ 
	$$  __$$< $$  __|    \____$$\   $$ |   $$  __$$\ $$ |  \__|$$ |$$ /  $$ |$$ /  $$ |$$$$$$$$ |
	$$ |  $$ |$$ |      $$\   $$ |  $$ |   $$ |  $$ |$$ |      $$ |$$ |  $$ |$$ |  $$ |$$   ____|
	$$ |  $$ |$$$$$$$$\ \$$$$$$  |  $$ |   $$$$$$$  |$$ |      $$ |\$$$$$$$ |\$$$$$$$ |\$$$$$$$\ 
	\__|  \__|\________| \______/   \__|   \_______/ \__|      \__| \_______| \____$$ | \_______|
																			 $$\   $$ |          
																			 \$$$$$$  |          
																			  \______/       
```


## Overview

The Can2Go REST bridge is a custom script written in LUA to extend the functionality of the can2go GW2 Gateway.
The script takes care of interpreting the EnOcean protocol and if necessary call a URL in the following format: http://localhost:8080/sensorId/status

## Requirements

Obviously a Can2Go Gateway is needed

## Installation

Add the content of the script to an available LUA programming slot within the Can2Go administration page.

## How to contribute

- Find a better way to enumerate through available slots (how can this be achieved dynamically?)
- Start modelling objects and start abstracting things
- Feel free to correct any mistakes I did because of my spare knowledge of the LUA scripting language