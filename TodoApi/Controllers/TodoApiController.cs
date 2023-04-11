using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using TodoApi.Models;

namespace TodoApi.Controllers
{
    [Route("/api/[controller]/[action]")]
    [ApiController]
    public class TodoApiController : ControllerBase
    {
        public static List<TodoItem> TodoItems = new List<TodoItem> {
            new TodoItem {
                Id = 1,
                Title = "Swimming",
                Date = "2023-04-02",
                Description = "Swimming description",
                StartTime = "12:30 PM",
                EndTime = "3:00 PM",
                StatusId = 1
            },

            new TodoItem {
                Id = 2,
                Title = "Jogging",
                Date = "2023-04-05",
                Description = "Jogging description",
                StartTime = "5:00 PM",
                EndTime = "7:00 PM",
                StatusId = 1
            }
         };
        List<TodoStatus> TodoStatuses = new List<TodoStatus> {
            new TodoStatus {
                Id = 1,
                title = "Pending"
            },

            new TodoStatus {
                Id = 2,
                title = "In Progress"
            },

            new TodoStatus {
                Id = 3,
                title = "Done"
            }
         };

        [Route("/api/[controller]/[action]")]
        [HttpGet]

        public ActionResult<List<TodoItem>> GetAll()
        {
            return Ok(TodoItems);
        }

        [HttpGet]
        public ActionResult<List<TodoStatus>> GetStatus()
        {
            return Ok(TodoStatuses);
        }

        [HttpGet("{id}")]

        public ActionResult<TodoItem> Get(int? id)
        {
            TodoItem? todoItem = TodoItems.Find(item => item.Id == id);
            if (todoItem == null) return BadRequest("Item Not Found");

            return Ok(todoItem);
        }

        [HttpPost]
        public ActionResult<List<TodoItem>> Add(TodoItem todoItem)
        {
            todoItem.Id = 1;
            if (TodoItems.Count > 0) todoItem.Id = TodoItems[TodoItems.Count - 1].Id + 1;
            TodoItems.Add(todoItem);
            return Ok(TodoItems);
        }

        [HttpPut]
        public ActionResult<List<TodoItem>> Update(TodoItem todoItem)
        {
            TodoItem? itemToUpdate = TodoItems.Find(item => item.Id == todoItem.Id);
            if (itemToUpdate == null) return BadRequest("Item Not Found");

            itemToUpdate.Title = todoItem.Title;
            itemToUpdate.Description = todoItem.Description;

            itemToUpdate.Date = todoItem.Date;
            itemToUpdate.StartTime = todoItem.StartTime;
            itemToUpdate.EndTime = todoItem.EndTime;
            itemToUpdate.StatusId = todoItem.StatusId;


            return Ok(TodoItems);
        }

        [HttpDelete("{id}")]

        public ActionResult<List<TodoItem>> Delete(int? id)
        {
            TodoItem? todoItem = TodoItems.Find(item => item.Id == id);
            if (todoItem == null) return BadRequest("Item Not Found");
            TodoItems.Remove(todoItem);
            return Ok(TodoItems);
        }


    }
}