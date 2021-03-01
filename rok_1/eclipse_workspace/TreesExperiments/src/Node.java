
/** Node, also known as smallest part of binary tree. It has three fields - value, left child, right child. Left child and right child are initialized with null.
 * @author gabriel
 *
 * @param <U>
 */
public class Node <U> {
	
		public U value;
		public Node <U> left;
		public Node <U> right;
		
		Node(U value) {
			this.value = value;
			this.left = null;
			this.right = null;
		}
	}
	