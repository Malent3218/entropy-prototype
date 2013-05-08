import UnityEngine

class GUIController (MonoBehaviour): 

	public matter as TerrainController
	public leapController as GameObject
	
	screenPos as Vector2
	draw as bool

	def OnGUI ():
		if matter != null:
			if GUI.Button (Rect (50, 15, 80, 30), "Main Menu"):
				Application.LoadLevel (0)
			GUI.Box (Rect (330, 15, matter.matterLeft*3, 30), "Matter")
		if draw:
			GUI.Box (Rect (screenPos.x, screenPos.y, 20, 20), "+")
		else:
			GUI.Box (Rect (screenPos.x, screenPos.y, 20, 20), "O")
		
	def Update ():
		if Input.GetKey("escape"):
			Application.Quit()
		screenPos = leapController.GetComponent(LeapController).GUIPos;
		draw = leapController.GetComponent(LeapController).getTouch;