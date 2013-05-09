import UnityEngine
		
class Finish(MonoBehaviour):

	public player as GameObject
	
	def OnCollisionEnter (collision as Collision):
			if (collision.collider == player.collider) and Application.loadedLevel < Application.levelCount - 1:
				Application.LoadLevel(Application.loadedLevel + 1)