import UnityEngine

class FollowCamera (MonoBehaviour): 

	tr as Transform
	public target as Transform
	public x as single
	public y as single
	public z as single
	public lockX as bool
	public lockY as bool
	public lockZ as bool
	public damp as single

	def Start ():
		tr = transform
	
	def Update ():
		offset as Vector3 = Vector3.Normalize(target.TransformDirection(x, y, -z)) * Mathf.Sqrt(x*x + y*y + z*z);
		if not lockX:
			tr.position.x = Mathf.Lerp(tr.position.x, target.position.x + offset.x, Time.deltaTime * damp)
		if not lockY:
			tr.position.y = Mathf.Lerp(tr.position.y, target.position.y + offset.y, Time.deltaTime * damp)
		if not lockZ:
			tr.position.z = Mathf.Lerp(tr.position.z, target.position.z + offset.z, Time.deltaTime * damp)
		tr.localRotation = target.rotation
