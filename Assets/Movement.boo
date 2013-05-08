import UnityEngine

class Movement (MonoBehaviour): 
	
	tr as Transform
	public obj as GameObject
	public speed as single
	
	def Start ():
		tr = obj.transform
	
	def Update ():
		tr.position.x += speed * Time.deltaTime
