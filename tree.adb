with Ada.Unchecked_Deallocation;
with Ada.Unchecked_Deallocation;
with stack;
with tree;


package body tree is
   procedure FreeNode is new Ada.Unchecked_Deallocation(Node, BinarySearchTreePoint);

   procedure init(Root: in out BinarySearchTreePoint; emptyRec: BinarySearchTreeRecord) is
   begin
      Root:= new Node;
      Root.Ltag := False;
      Root.Llink := Root;
      Root.Rlink := Root;
      Root.Rtag := True;
      Root.Info := EmptyRec;
   end;

   procedure InsertBinarySearchTree(Root: in out BinarySearchTreePoint;
				                      custName: in Akey; custPhone: Akey) is
      P, T: BinarySearchTreePoint;
   begin
      put_line("inserting");
      P:= Root;
      loop
         if custName < P.Info then
            if P.LTag then
               P:= P.LLink;
            else
               allocateNode(T, custname, custphone);
               insertNode(P, T, custname, custphone);
               putrec(T.Info);
               exit;
            end if;
         elsif custName > P.Info then
            if P.RTag then
               P:= P.RLink;
            else
               allocateNode(T, custname, custphone);
               insertNode(P, T, custname, custphone);
               putrec(T.Info);
               exit;
            end if;
         end if;
      end loop;
   end InsertBinarySearchTree;

   procedure insertNode(P: in out BinarySearchTreePoint; Q: in out BinarySearchTreePoint;
                        name: in Akey; number: in Akey) is
   begin
      if name < P.Info then
         if getName(P.Info) /= emptyRec then
            put("Left subtree of ");
            putname(getname(P.Info)); New_Line;
         else
            put_line("new root created");
         end if;
         Q.LTag:= P.LTag; Q.LLink:= P.LLink;
         P.LLink:= Q; P.LTag:= true;
         Q.RTag:= false; Q.RLink:= P;
      else
         if getName(P.Info) /= emptyRec then
            put("Right subtree of ");
            putname(getname(P.Info)); New_Line;
         else
            put("new root created");
         end if;
         Q.RTag:= P.RTag; Q.RLink:= P.RLink;
         P.RLink:= Q; P.RTag:= true;
         Q.LTag:= false; Q.LLink:= P;
      end if;
   end insertNode;

   procedure allocateNode(Q: out BinarySearchTreePoint;
                          name: in AKey; number: in AKey) is
   begin
      Q:= new Node'(null, null, false, true, makeRecord(name, number));
      Q.LLink:= Q;
      Q.RLink:= Q.LLink;
   end;

   procedure DeleteRandomNode(name: in out Akey; Root: in out BinarySearchTreePoint) is
       R, S, T: BinarySearchTreePoint;
   begin
      if Root.Llink = Root then  --if tree is empty
         Put_Line("No customer search possible. The tree is empty.");
      else
         R := Root.Llink; --R points to first node
         loop
            if name < R.info then --checks if insertion key is less then node pointed to
               if R.LTag then
                  R := R.Llink;
              else
                  Put_Line("That name is not in the tree."); New_Line; --searched all the way left
                  exit;
               end if;
            elsif name > R.Info then --searches to the right
              if R.RTag then
                  R := R.RLink;
               else
                  Put_Line("That name is not in the tree."); New_Line; --searched all the way left of subtree
                  exit;
               end if;
            else
               Put_Line("Name has been deleted from the tree."); New_Line; --node found and deleted
               S:= InOrderSuccessor(R); -- replace with inorder successor
              S.Ltag:= R.Ltag; --update successor tag
               S.Llink:= R.Llink; -- update successor LLink
               if not R.RTag then
                  R.Llink.Rlink:= R.RLink;
                  R.Llink.RTag:= R.RTag;
               end if;
              if R.RTag then
                  T:= InOrderSuccessor(S);
                  S.RLink:= T;
                  T.Llink:= S;
                  R.Llink.Rlink.Rlink:= S;
              end if;
              FreeNode(R);
              exit;
            end if;
         end loop;
      end if;
   end DeleteRandomNode;

   procedure FindCustomerIterative(Root: in BinarySearchTreePoint; CustomerName: in AKey;
                                   CustomerPoint: out BinarySearchTreePoint) is
      T: BinarySearchTreePoint;
   begin
      T:= Root;
      loop
         if CustomerName < T.Info and T.LTag then
            T:= T.LLink;
         elsif CustomerName > T.Info and T.RTag then
            T:= T.RLink;
         else
            exit;
         end if;
      end loop;
      CustomerPoint:= T;
      if getName(T.Info) /= customerName then
         put_line("no record found");
      else
         put("Record found for: ");
         putName(getName(T.Info)); new_Line;
      end if;
   end FindCustomerIterative;

   procedure FindCustomerRecursive(Root: in BinarySearchTreePoint; CustomerName: in AKey;
                                   CustomerPoint: out BinarySearchTreePoint) is
      T: BinarySearchTreePoint:= Root;
   begin
      if CustomerName > T.Info and T.RTag then
         FindCustomerRecursive(T.RLink, CustomerName, CustomerPoint);
      elsif CustomerName < T.Info and T.LTag then
         FindCustomerRecursive(T.LLink, CustomerName, CustomerPoint);
      elsif CustomerName /= getName(T.Info) then
         CustomerPoint:= null;
         put_line("no record found.");
      else
         put("record found for: "); putRec(T.info);
      end if;
   end FindCustomerRecursive;

   function InOrderSuccessor(TreePoint: in BinarySearchTreePoint)
                              return BinarySearchTreePoint is
      T: BinarySearchTreePoint:= TreePoint;
   begin
      if T.RTag then
         T:= T.RLink;
         while T.LTag loop
            T:= T.LLink;
         end loop;
      else
         T:= T.RLink;
      end if;
      return T;
   end InOrderSuccessor;

   procedure PreOrderTraversalIterative(TreePoint: in out BinarySearchTreePoint;
                                        Root: in BinarySearchTreePoint) is
      T: BinarySearchTreePoint:= TreePoint;
      Q: BinarySearchTreePoint:= T;
   begin
      put("preorder traversal from "); putName(getName(T.Info));
      New_Line;
      if T = Root.LLink then
         if T.LTag then
            T:= T.LLink;
         else
            T:= T.RLink;
         end if;
      else
        putRec(T.Info);
      end if;
      Q:= T;
      loop
         putRec(Q.Info);
         if Q.LTag then
            Q:= Q.LLink;
         else
            if not Q.RTag then
               Q:= Q.RLink.Rlink;
            else
               Q:= Q.Rlink;
            end if;
         end if;
         if Q = Root then
            Q:= Q.LLink;
         end if;
         exit when Q = T;
      end loop;
   end PreOrderTraversalIterative;

   procedure PreOrderRecursive (P : in out BinarySearchTreePoint) is
   begin
      putRec(P.Info);
      if P.LTag then
         PreOrderRecursive(P.LLink);
      end if;
      if P.RTag then
         PreOrderRecursive(P.RLink);
      end if;
   end PreOrderRecursive;

   function PostOrderSuccessor(TreePoint: in out BinarySearchTreePoint)
                              return BinarySearchTreePoint is
      Q, P: BinarySearchTreePoint:= TreePoint;
   begin
      if P.RTag then
         Q:= P.RLink;
      else
         while not Q.LTag loop
            Q:= Q.LLink;
         end loop;
         Q:= Q.LLink;
      end if;
      return Q;
   end PostOrderSuccessor;

 	procedure PostOrderTraversalIterative(TreePoint: in out BinarySearchTreePoint) is
      P, T: BinarySearchTreePoint:= TreePoint;
      package stak is new stack(50, BinarySearchTreePoint); use stak;
   begin
      put("post order iterative traversal from "); putName(getName(T.info));
      New_Line;
      P:= PostOrderSuccessor(T);
      stak.push(P);
      P:= PostOrderSuccessor(P);
		while P /= T loop
         stak.push(P);
         P:= PostOrderSuccessor(P);
      end loop;
      while not stak.isEmpty loop
         stak.pop(P);
         putName(getName(P.Info));
         New_line;
      end loop;
      putName(getName(TreePoint.Info));
      New_Line;
   end PostOrderTraversalIterative;

	procedure PostOrderRecursive(TreePoint: in out BinarySearchTreePoint) is
   begin
      if TreePoint.LTag then
         PostOrderRecursive(TreePoint.LLink);
      end if;
      if TreePoint.RTag then
         PostOrderRecursive(TreePoint.RLink);
      end if;
      putName(getName(TreePoint.info));
      New_Line;
   end PostOrderRecursive;

   procedure ReverseInOrder(P: in out BinarySearchTreePoint) is
      T : BinarySearchTreePoint := P;
   begin
      if P.RTag then
         ReverseInOrder(P.RLink);
      end if;
      putRec(P.Info);
      if P.LTag then
         ReverseInOrder(P.LLink);
      end if;
   end ReverseInOrder;

   procedure BuildBST(file: String) is
      Input_Exception: Exception;
      input: KIO.File_Type;
      Root: BinarySearchTreePoint;
      op, T1, T2: AKey;
      temp1, temp2: BinarySearchTreePoint;
   begin
      init(Root, makeRecord(emptyRec, emptyRec));
      Open(input, in_file, "C:\Users\curti\OneDrive\Desktop\ada programs\obj\input3.txt");
      begin
         while not End_of_file(input) loop
            Read(input, op);
            New_Line;
            case getVal(op) is
               when 1 =>
                  Read(input, T1); Read(input, T2);
                  InsertBinarySearchTree(Root, T1, T2);
               when 2 =>
                  Read(input, T1);
                  put("iterative search for "); putname(T1); New_Line;
                  FindCustomerIterative(Root, T1, temp1);
               when 3 =>
                  Read(input, T1);
                  put("recursive search for "); putname(T1); New_Line;
                  FindCustomerRecursive(Root.LLink, T1, temp1);
               when 4 =>
                  Read(input, T1);
                  FindCustomerIterative(Root, T1, temp1);
                  put("Traversing in order from "); putName(T1);
                  New_Line;
                  putRec(temp1.info);
                  temp2 := InOrderSuccessor(temp1);
                  while temp2 /= temp1 loop
                     if temp2 /= Root then
                        putrec(temp2.Info);
                     end if;
                     temp2 := InOrderSuccessor(temp2);
                  end loop;
               when 5 =>
                  put_line("in order traverse from root: ");
                  temp2 := Root.Llink;
                  while temp2 /= Root loop
                     putrec(temp2.Info);
                     temp2 := InOrderSuccessor(temp2);
                  end loop;
               when 6 =>
                  put("Deleting ");
                  Read(input, T1);
                  PutName(T1);
                  New_Line;
                  FindCustomerIterative(Root, T1, temp1);
                  DeleteRandomNode(T1, Root);
               when 7 =>
                  temp1 := Root.LLink;
                  put("reverse in order traversal from ");
                  putname(getname(temp1.Info));
                  New_Line;
                  ReverseInOrder(Root.LLink);
               when 8 =>
                  PreOrderTraversalIterative(Root.LLink, Root);
               when 9 =>
                  PostOrderTraversalIterative(Root.LLink);
               when 10 =>
                  New_Line;
                  put_line("recursive post order traversal ");
                  PostOrderRecursive(Root.LLink);
               when 0 =>
                  exit;
               when others =>
                  raise Input_Exception;
            end case;
         end loop;
         Close(input);
      end;
   end BuildBST;
end tree;
