import React from "react";
import CharacterLink from "./CharacterLinks";

function ProfileBar({handleLogOut, selectCharacter, currentUser, currentCharacter})
{
    
    let characterLinks = currentUser != null && currentUser.characters != null ? currentUser.characters.map(character => <CharacterLink key={character.name + character.id} selectCharacter={selectCharacter} character={character} currentCharacter={currentCharacter}/>): null



    return(
        <div className="user-display">

            <h2>Welcome back, {currentUser.username}!</h2>
            <div className="links-container">{characterLinks}</div>
            <div className={`player-icon ${currentUser.admin ? "blue-banner" : ""}`}>
                <img src={currentUser != null ? currentUser.image : ""} alt="user image" />
                <p>{currentUser.username}</p>
                <button onClick={handleLogOut}>Log Out</button>
            </div>
        </div>
    )
}

export default ProfileBar