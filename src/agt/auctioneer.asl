// Agent auctioneer in project envCoordinationMAS

/* Initial beliefs and rules */

/* Initial goals */


/* Plans */

+!start(Id,P)
   <- makeArtifact(Id, "envCoordinationMAS.AuctionArtifact", [], ArtId);
      .print("Auction artifact created for ",P);
      Id::focus(ArtId);  // place observable properties of this auction in a particular name space
      Id::start(P);
      .broadcast(achieve,focus(Id));  // ask all others to focus on this new artifact
      .at("now + 5 seconds", {+!decide(Id)}).

+!decide(Id)
   <- Id::stop.
   
   +NameSpace::winner(W) : W \== no_winner
   <- ?NameSpace::task(S);
      ?NameSpace::best_bid(V);
      .print("Winner for ", S, " is ",W," with ", V).
   

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have a agent that always complies with its organization  
{ include("$jacamoJar/templates/org-obedient.asl") }
