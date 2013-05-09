import UnityEngine
		
class Finish(MonoBehaviour):

	public player as GameObject
	
	def OnCollisionEnter (collision as Collision):
			if (collision.collider == player.collider) and Application.loadedLevel < Application.levelCount - 1:
<<<<<<< HEAD
				Application.LoadLevel(Application.loadedLevel + 1)
=======
				Application.LoadLevel(Application.loadedLevel + 1)
>>>>>>> ec896f7c2ebb24e661d65b8727c78728480a3f4d
