import React from "react";

function CharacterLink({selectCharacter, character, currentCharacter}) {

    return (
        <div onClick={() => selectCharacter(character)} className={`character-link ${currentCharacter != null && character.id === currentCharacter.id ? "blue-banner" : ""}`} style={{"float": "left"}}>
            <p>{character.name + " " + character.title}</p>
            <div>
                <p>Class: {character.klass}</p>
                <p>Level: {character.level} Xp: {character.xp}</p>
                <p>Gold: {character.gold}</p>
            </div>
        </div>
    )
}

export default CharacterLink