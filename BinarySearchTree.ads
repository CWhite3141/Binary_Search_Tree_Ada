with Ada.Sequential_IO, Ada.Text_IO, Ada.Integer_Text_IO, stack;
use Ada.Text_IO, Ada.Integer_Text_IO;

generic

   type Akey is private;
   type BinarySearchTreeRecord is private;

   with function "<"(TheKey: in Akey; ARecord: in BinarySearchTreeRecord)
      return Boolean;
   with function ">"(TheKey: in Akey; ARecord: in BinarySearchTreeRecord)
      return Boolean;
   with function "="(TheKey: in Akey; ARecord: in BinarySearchTreeRecord)
      return Boolean;
   with procedure putRec (ARecord: in BinarySearchTreeRecord);
   with procedure putName (Name: in AKey);
   with function getName (ARecord: in BinarySearchTreeRecord)
                          return AKey;
   with function makeRecord (P: in Akey; Q: in AKey)
                             return BinarySearchTreeRecord;
   with function getVal (P: in AKey) return Integer;

package BinarySearchTree is
   type BinarySearchTreePoint is limited private;
   package KIO is new Ada.Sequential_IO(AKey);
   use KIO;
   procedure InsertBinarySearchTree(Root: in out BinarySearchTreePoint;
                                    custName: in Akey; custPhone: Akey );
   procedure FindCustomerIterative(Root: in BinarySearchTreePoint;
                                   CustomerName: in Akey;
                                   CustomerPoint: out BinarySearchTreePoint);
   procedure FindCustomerRecursive(Root: in BinarySearchTreePoint;
                                   CustomerName: in Akey;
                                   CustomerPoint: out BinarySearchTreePoint);
   function InOrderSuccessor(TreePoint: in BinarySearchTreePoint) return BinarySearchTreePoint;
   procedure PostOrderIterative(TreePoint: in BinarySearchTreePoint);
   procedure PostOrderRecursive(TreePoint: in out BinarySearchTreePoint);
   procedure ReverseInOrder (P: in out BinarySearchTreePoint);
   procedure allocateNode(Q: out BinarySearchTreePoint;
                           name: in AKey; num : in AKey);
   procedure insertNode(P: in out BinarySearchTreePoint;
                         Q: in out BinarySearchTreePoint; name : in Akey;
                        number: IN Akey);
   procedure DeleteRandomNode(Q: in out BinarySearchTreePoint; Root: in out BinarySearchTreePoint);
   procedure PreOrderIterative(TreePoint: in out BinarySearchTreePoint; Root: BinarySearchTreePoint);
   procedure makeTree(file: String);
   dummy: Akey;
private
   type Node;
   type BinarySearchTreePoint is access Node;
   type Node is
      record
         Llink, Rlink: BinarySearchTreePoint:= null;
         Ltag, Rtag: Boolean:= False ; -- True indicates pointer to lower level, False a thread.
         Info: BinarySearchTreeRecord;
      end record;
end BinarySearchTree;
