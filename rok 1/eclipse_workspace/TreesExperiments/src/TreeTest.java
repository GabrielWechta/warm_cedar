
public class TreeTest {

	public static void main(String[] args) {
		
		System.out.println("/////INTEGER/////");
		BinaryTree<Integer>  bt_i = new BinaryTree<Integer>();
		bt_i.insert(1);
		bt_i.insert(2);
		bt_i.insert(3);
		bt_i.insert(4);
		bt_i.insert(5);
		bt_i.insert(6);
		bt_i.insert(7);
		bt_i.draw();
		
		System.out.println(bt_i.search(3));
		bt_i.delete(3);
		System.out.println(bt_i.search(3));
		bt_i.draw();
		
		System.out.println("/////DOUBLE/////");
		BinaryTree<Double>  bt_d = new BinaryTree<Double>();
		bt_d.insert(1.0);
		bt_d.insert(2.0);
		bt_d.insert(Math.E);
		bt_d.insert(3.0);
		bt_d.insert(6.72341623);
		bt_d.insert(7.99);
		bt_d.insert(Math.PI);
		bt_d.insert(4.0);
		bt_d.insert(5.5);
		bt_d.draw();
		
		System.out.println(bt_d.search(Math.PI));
		bt_d.delete(Math.PI);
		System.out.println(bt_d.search(Math.PI));
		bt_d.draw();
		
		System.out.println("/////STRING/////");
		BinaryTree<String>  bt_s = new BinaryTree<String>();
		bt_s.insert("Adam");
		bt_s.insert("Ewa");
		bt_s.insert("Bell String");
		bt_s.insert("Behemot");
		bt_s.insert("Bell String");
		bt_s.draw();
		
		System.out.println(bt_s.search("Behemot"));
		bt_s.delete("Behemot");
		System.out.println(bt_s.search("Behemot"));
		bt_s.draw();
		
	}

}
