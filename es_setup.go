package main

import (
	"bytes"
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"time"

	_ "github.com/mattn/go-sqlite3"
)

var ES_PATH = "http://localhost:9200/"

func main() {
	type Attachment struct {
		Field        string `json:"field"`
		IndexedChars int64  `json:"indexed_chars"`
	}

	type Processors struct {
		Attachment Attachment `json:"attachment"`
	}

	type AttachmentStruct struct {
		Description string       `json:"description"`
		Processors  []Processors `json:"processors"`
	}

	// Init Elasticsearch attachment
	attachment := &AttachmentStruct{
		Description: "Process documents",
		Processors: []Processors{
			Processors{
				Attachment: Attachment{
					Field:        "thedata",
					IndexedChars: -1,
				},
			},
		},
	}

	fmt.Println(attachment)

	b, err := json.Marshal(attachment)
	CheckError(err)
	fmt.Println(b)

	PutJSON(ES_PATH+"_ingest/pipeline/attachment", b)

	type Settings struct {
		NumberOfShards   int64 `json:"number_of_shards"`
		NumberOfReplicas int64 `json:"number_of_replicas"`
	}

	type IndexStruct struct {
		Settings Settings `json:"settings"`
	}

	// Init Elasticsearch index
	index := &IndexStruct{
		Settings{
			NumberOfShards:   4,
			NumberOfReplicas: 0,
		},
	}

	b, err = json.Marshal(index)
	CheckError(err)
	fmt.Println(b)

	PutJSON(ES_PATH+"lr_index", b)

	// Open sqlite3 database
	db, err := sql.Open("sqlite3", "./libreread.db")
	CheckError(err)

	stmt, err := db.Prepare("update user set full_text_search=? where id=?")
	CheckError(err)

	_, err = stmt.Exec(1, 1)
	CheckError(err)

	db.Close()
}

func CheckError(err error) {
	if err != nil {
		panic(err)
	}
}

var myClient = &http.Client{Timeout: 10 * time.Second}

func PutJSON(url string, message []byte) {
	req, err := http.NewRequest("PUT", url, bytes.NewBuffer(message))
	CheckError(err)
	res, err := myClient.Do(req)
	CheckError(err)
	content, err := ioutil.ReadAll(res.Body)
	CheckError(err)
	fmt.Println(string(content))
}
