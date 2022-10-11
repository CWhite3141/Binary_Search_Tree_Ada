with stack;

package body genericBST is

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
      P, T : BinarySearchTreePoint;
   begin
      put_line("inserting");
      P := Root;
      loop
         if custName < P.Info then
            if P.LTag then
               P := P.LLink;
            else
               allocateNode(T, custname, custphone);
               insertNode(P, T, custname, custphone);
               putrec(T.Info);
               exit;
            end if;
         elsif custName > P.Info then
            if P.RTag then
               P := P.RLink;
            else
               allocateNode(T, custname, custphone);
               insertNode(P, T, custname, custphone);
               putrec(T.Info);
               exit;
            end if;
         end if;
      end loop;
   end InsertBinarySearchTree;

   procedure insertNode (P: in out BinarySearchTreePoint; Q: in out BinarySearchTreePoint;
                        name: in Akey; number: in Akey) is
   begin
      if name < P.Info then
         if getName(P.Info) /= emptyRec then
            put("Left subtree of ");
            putname(getname(P.Info)); New_Line;
         else
            put_line("new root created");
         end if;
         Q.LTag := P.LTag; Q.LLink := P.LLink;
         P.LLink := Q; P.LTag := true;
         Q.RTag := false; Q.RLink := P;
      else
         if getName(P.Info) /= emptyRec then
            put("Right subtree of ");
            putname(getname(P.Info)); New_Line;
         else
            put("new root created");
         end if;
         Q.RTag := P.RTag; Q.RLink := P.RLink;
         P.RLink := Q; P.RTag := true;
         Q.LTag := false; Q.LLink := P;
      end if;
   end insertNode;

   procedure FindCustomerIterative(Root: in BinarySearchTreePoint;
                                   CustomerName: in AKey;
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
         put("Record found: ");
         putrec(T.Info);
      end if;
   end FindCustomerIterative;

	procedure FindCustomerRecursive(Root: in BinarySearchTreePoint;
				          CustomerName:  in AKey;
				          CustomerPoint:  out BinarySearchTreePoint) is
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
         put("record found: "); putrec(T.Info);
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

   procedure DeleteRandomNode(Q: in out BinarySearchTreePoint;
                              Root : in out BinarySearchTreePoint) is
      R, S, T : BinarySearchTreePoint;
   begin
      T := Q;
      if T.Rlink = null then
         Q := T.LLink;
      else
         if T.Llink = null then
            Q := T.RLink;
         end if;
         R := T.RLink;
         if R.Llink = null then
            R.LLink := T.LLink;
            Q := R;
         else
            S := R.LLink;
            while S.Llink /= null loop
               R := S; S := R.LLink;
            end loop;
            S.LLink := T.LLink;
            R.LLink := S.RLink;
            S.RLink := T.RLink;
            Q := S;
         end if;
      end if;
   putrec(T.Info);
   if Root.LLink = T then
      Root.LLink := Q;
   else
      if T.LLink = Q then
         T.LLink := Q;
      else
         T.RLink := Q;
      end if;
   end if;
   end DeleteRandomNode;

   procedure PreOrderTraversalIterative(TreePoint: in out BinarySearchTreePoint;
                      Root : in BinarySearchTreePoint) is
      T : BinarySearchTreePoint := TreePoint;
      Q : BinarySearchTreePoint;
   begin
      put("preorder traversal starting from "); putName(getName(T.Info));
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
         putRec(P.Info);
      end loop;
      putRec(TreePoint.Info);
   end PostOrderTraversalIterative;

	procedure PostOrderRecursive(TreePoint: in out BinarySearchTreePoint) is
   begin
      if TreePoint.LTag then
         PostOrderRecursive(TreePoint.LLink);
      end if;
      if TreePoint.RTag then
         PostOrderRecursive(TreePoint.RLink);
      end if;
      putRec(TreePoint.info);
   end PostOrderRecursive;

   procedure allocateNode(Q: out BinarySearchTreePoint;
                           name: in AKey; number: in AKey) is
   begin
      Q:= new Node'(null, null, false, true, makeRecord(name, number));
      Q.LLink:= Q;
      Q.RLink:= Q.LLink;
   end;

   procedure BuildBST(file: String) is
      Input_Exception: Exception;
      input: KIO.File_Type;
      Root: BinarySearchTreePoint;
      op, T1, T2: AKey;
      temp1, temp2: BinarySearchTreePoint;
   begin
      init(Root, makeRecord(emptyRec, emptyRec));
      Open(input, in_file, "C:\Users\curti\OneDrive\Desktop\ada programs\obj\input.txt");
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
                  put_line("Traversing in order from ");
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
                  temp2 := Root.LLink;
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
                  DeleteRandomNode(temp1, Root);
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
                  put_line("recursive post order traversal ");
                  PostOrderRecursive(Root.LLink);
               when others =>
                  raise Input_Exception;
            end case;
         end loop;
         Close(input);
      end;
   end BuildBST;
end genericBST;
