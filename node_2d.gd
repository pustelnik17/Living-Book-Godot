extends Node2D


var api_key = "YOUR_API_KEY_HERE"
var endpoint = "https://api.openai.com/v1/completions"

func _ready():
	var request = HTTPRequest.new()
	request.connect("request_completed", self, "_on_request_completed")
	add_child(request)
	
	# Example prompt
	var prompt = "Once upon a time, "
	var data = {
		"prompt": prompt,
		"max_tokens": 50,
		"temperature": 0.7,
		"n": 1
	}
	
	request.request(endpoint, {"Content-Type": "application/json", "Authorization": "Bearer " + api_key}, to_json(data), "POST")

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse(body)
		var choices = json.result.choices
		if choices.size() > 0:
			var generated_text = choices[0].text
			# Do something with the generated text
			print(generated_text)
	else:
		# Handle errors
		print("Error:", response_code, body)

