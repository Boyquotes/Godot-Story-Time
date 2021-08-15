extends Control

var Intro="Welcome to Story time! Let's make some fun stories!"
var CurrentStory
var player_words=[]
#Template dictionary
var Template=[
	{
		"prompts":["a name ","a gerund (verb ending with ing) ","the name of a city ","an adjective "],
		"Story": "I met a man named %s who was very good at %s when i visited %s. He was very %s."
	},
	{
		"prompts":["a name of an animal ","a name","a biome ","a food item "],
		"Story": "There was once a %s named %s who lived in %s.It loved eating %s. "
	}
]

#Nodes
onready var DisplayText=$VBoxContainer/DisplayText
onready var InputText=$VBoxContainer/HBoxContainer/LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	SetStory()
	IsStoryDone()
	InputText.grab_focus()

#Pick a story from list of templates
func SetStory():
	randomize()
	CurrentStory=Template[randi()%Template.size()]

#Check if all prompts for the current story have been filled
func CheckIfPromptsDone():
	return CurrentStory.prompts.size()==player_words.size()

#Prompt player to fill in the story
func PromptPlayer():
	DisplayText.text=Intro+"May I have "+CurrentStory.prompts[player_words.size()]+"please?"
	
#Tell final story with all prompts filled in
func TellStory():
	DisplayText.text=CurrentStory.Story%player_words
	EndGame()

#End the game
func EndGame():
	InputText.queue_free()
	InputText.hide()
	$VBoxContainer/HBoxContainer/TextureButton/OkText.text="Again!"

#Self explanatory
func IsStoryDone():
	if CheckIfPromptsDone():
		TellStory()
	else:
		PromptPlayer()
	

#Add word in LineEdit to player_words and clear LineEdit
func AddToPlayerWords():
	if len(InputText.text)!=0:
		player_words.append(InputText.text)
		InputText.clear()
	IsStoryDone()

#Enter button callback
func _on_LineEdit_text_entered(new_text):
	 AddToPlayerWords()

#Texture button press callback
#Incase game has ended texture button changes prompt to restart 
func _on_TextureButton_pressed():
	if CheckIfPromptsDone():
		get_tree().reload_current_scene()
	else:
		 AddToPlayerWords()
	






	


