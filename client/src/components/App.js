import React, { useState, useEffect } from "react";
import { Routes, Route } from "react-router-dom";
import "../App.css";
import Navbar from "./NavBar";
import Home from "./Home";
import Town from "./Town";
import ProfileBar from "./ProfileBar";
import CreateUserForm from "./CreateUserForm";
import Shop from "./Shop";
import Academy from "./Academy";
import LoginForm from "./LoginForm";
import Dungeon from "./Dungeon";
import AdminControls from "./AdminControls";

function App() {

    const [users, setUsers] = useState([])
    const [currentUser, setCurrentUser] = useState(null)
    const [currentCharacter, setCurrentCharacter] = useState(null)
    const [newUsername, setUsername] = useState("")
    const [newPassword, setPassword] = useState("")
    const [newProfileImg, setProfileImg] = useState("")
    const [login, setLogin] = useState(false);
    const [loginUser, setLoginUser] = useState("")
    const [loginPass, setLoginPass] = useState("")
    const [errors, setErrors] = useState([])
    const [currentUserPassword, setCurrentUserPassword] = useState("")

    useEffect(() => {
        fetch("/users")
        .then(res => {
            if (res.ok) {
                res.json().then(setUsers)
            }
            else {
                res.json().then(e => setErrors([...errors, e.error]))
            }
        })

    }, [currentCharacter])



    function handleLogin(username, password) {
      
        fetch(`/users/login/${username}/${password}`)
        .then(res => {
            if (res.ok) {
                res.json().then(user => {
                    fetch(`/users/${user.id}/characters`)
                .then(res => res.json())
                .then(characters => {
                setCurrentUser({...user, characters})

                if (currentCharacter != null) {
                    setCurrentCharacter(characters.find(character => character.id == currentCharacter.id))
                }
                else {
                    setCurrentCharacter(characters[0])
                }
                setCurrentUserPassword(password)
            })
                })
            }
            else {
                res.json().then(error => setErrors([...errors, error.error]))
            }
        })
        
        setLoginUser('')
        setLoginPass('')
        setLogin(false)
            
        
    }

    function updateCurrentCharacter(char) {
        setCurrentCharacter(char)
        updateCurrentUser()
    }

    function updateCurrentUser() {
        handleLogin(currentUser.username, currentUserPassword)
    }

    //User Functions
    

    function selectCharacter(char) {
        
        fetch(`/characters/${char.id}`)
        .then (res => {
        if (res.ok) {
            res.json().then(setCurrentCharacter)
        }
        else {
            res.json().then(error => setErrors([...errors, error.error]))
        }
    })

    }

    function handleUpdateLoginUser(e) {
        setLoginUser(e.target.value)
    }

    function handleUpdateLoginPass(e) {
        setLoginPass(e.target.value)
    }

    function handleLogOut() {
        setLogin(false)
        setCurrentUser(null)
        setCurrentCharacter(null)
    }

    function handleUpdateFormUsername(e) {
        setUsername(e.target.value)
    }

    function handleUpdateFormPassword(e) {
        setPassword(e.target.value)
    }

    function handleUpdateFormProfileImg(e) {
        setProfileImg(e.target.value)
    }

    function handleAddUser(e) {
        e.preventDefault()
        let newUser = {
            username: newUsername,
            password: newPassword,
            image: newProfileImg
        }

        fetch("/users", {
            method: "POST",
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(newUser)
        })
        .then(res => {
            if (res.ok) {
                res.json().then(user => {
                    setUsers([...users, user])
                    setCurrentUser(user)
                })

                setUsername("")
                setPassword("")
                setProfileImg("")
            }
            else {
                res.json().then(error => setErrors([...errors, error.error]))
            }
        })        

        
    }

    function handleAddCharacter(e, character) {
        e.preventDefault()

        let newCharacter = {
            name: character.name,
            title: "",
            xp: 0,
            klass: character.klass,
            strength: character.strength,
            dexterity: character.dexterity,
            wisdom: character.wisdom,
            constitution: character.constitution,
            intelligence: character.intelligence,
            charisma: character.charisma,
            gold: 25,
            user_id: currentUser.id

        }

        fetch("/characters", {
            method: "POST",
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(newCharacter)
        })
        .then(res => {
            if (res.ok) {
                res.json().then(updateCurrentCharacter)
            }
            else {
                res.json().then(error => setErrors([...errors, error.error]))
            }
        })
    }

    return(
        <div className={`App`}>
            <Navbar/>
            {currentUser == null ? <div className="login-buttons newUserForm">
                 <button className="button" onClick={() => setLogin(true)}>Log In</button> 
                <button className="button" onClick={() => {
                    setLogin(false)
                    setCurrentUser(null)
                }}>Sign Up</button>
                
            </div> : null}
            {currentUser != null ? <ProfileBar handleLogOut={handleLogOut} selectCharacter={selectCharacter} currentUser={currentUser} currentCharacter={currentCharacter}/> :
            login ? <LoginForm handleLogin={handleLogin} loginUser={loginUser} onChangeUsername={handleUpdateLoginUser} onChangePassword={handleUpdateLoginPass} loginPass={loginPass} />
            : <CreateUserForm handleAddUser={handleAddUser} newUsername={newUsername} onChangeUsername={handleUpdateFormUsername} newPassword={newPassword} onChangePassword={handleUpdateFormPassword} newProfileImg={newProfileImg} onChangeProfileImg={handleUpdateFormProfileImg}/>}
            
            {currentUser != null && currentUser.admin ? <AdminControls currentUser={currentUser}/> : null}
            <Routes>
                <Route path="/" element={<Home/>} />
                <Route path="/town" element={<Town/>} />
                <Route path="shop" element={<Shop updateCurrentCharacter={updateCurrentCharacter} currentCharacter={currentCharacter}/>} />
                <Route path="/academy" element={<Academy handleAddCharacter={handleAddCharacter} currentUser={currentUser} currentCharacter={currentCharacter} />} />
                <Route path="/dungeon" element={<Dungeon currentUser={currentUser} currentCharacter={currentCharacter} />} />
            </Routes>
            {errors.length > 0 && (
                <ul style={{ color: "red" }}>
                    {errors.map((error) => (
                    <li key={error}>{error}</li>
                    ))}
                </ul>
                )}
        </div>
    )
}

export default App